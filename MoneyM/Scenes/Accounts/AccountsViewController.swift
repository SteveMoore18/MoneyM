//
//  AccountsVC.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import UIKit
import Foundation

protocol DisplayAccounts: AnyObject {
	func displayAccounts(viewModel: AccountsModel.ViewModel)
    func deletedAccount(viewModel: AccountsModel.DeleteAccount.ViewModel)
    func displayEditAccounts(viewModel: AccountsModel.EditAccounts.ViewModel)
    func displaySwapAccounts(viewModel: AccountsModel.SwapAccount.ViewModel)
}

class AccountsViewController: UIViewController {

	// MARK: - IBOutlets
	@IBOutlet weak var accountsTableView: UITableView!
	
    @IBOutlet weak var newAccountButton: UIButton!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var btnNewAccount: UIButton!
    
    var interactor: AccountsBusinessLogic?
	var router: AccountsNavigate?
	var viewModel: AccountsModel.ViewModel?
	
	private var accountsTableViewCell: UIAccountTableViewCell?
    
    private var constants: Constants!
    
    private var selectedAccountIndexPath: IndexPath!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		// CleanSwift setup
		setup()
		
		otherInit()
	}
    
    public func updateAccountsBalance()
    {
        interactor?.requestAccounts()
        accountsTableView.reloadData()
    }
	
	// MARK: - private functions
	private func setup() {
		
		let viewController = self
		let accountsInteractor = AccountsInteractor()
		let accountsPresenter = AccountsPresenter()
		let accountsRouter = AccountsRouter()
		
		accountsInteractor.presenter = accountsPresenter
		accountsPresenter.viewController = viewController
		accountsRouter.viewController = viewController
		
		interactor = accountsInteractor
		router = accountsRouter
	}
	
	private func otherInit() {
		interactor?.requestAccounts()
		
		accountsTableView.delegate = self
		accountsTableView.dataSource = self
		
		splitViewController?.minimumPrimaryColumnWidth = accountsTableView.frame.width
		
		if !viewModel!.accounts.isEmpty {
            
            if let index = loadSelectedIndex() {
                selectedAccountIndexPath = IndexPath(row: index, section: 0)
                accountsTableView.selectRow(at: selectedAccountIndexPath,
                                            animated: true,
                                            scrollPosition: .none)
                
                let account = (viewModel?.accounts[index])!
                router?.showOperations(account: account)
            }
            
		}
        constants = Constants()
        newAccountButton.titleLabel?.font = constants.roundedFont(20)
        
        localizeText()
	}
    
    private func editAccounts()
    {
        accountsTableView.setEditing(!accountsTableView.isEditing, animated: true)
        
        let request = AccountsModel.EditAccounts.Request(isEditing: accountsTableView.isEditing)
        interactor?.editAccounts(request: request)
    }
    
    private func localizeText()
    {
        btnEdit.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
        btnNewAccount.setTitle(NSLocalizedString("new_account", comment: ""), for: .normal)
        title = NSLocalizedString("accounts", comment: "")
    }
    
    private func saveSelectedIndex(_ indexPath: IndexPath)
    {
        UserDefaults.standard.set(indexPath.row, forKey: "selectedIndex")
    }
    
    private func loadSelectedIndex() -> Int?
    {
        UserDefaults.standard.value(forKey: "selectedIndex") as? Int
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.set(nil, forKey: "selectedIndex")
		
		if let indexPath = accountsTableView.indexPathForSelectedRow
		{
			accountsTableView.deselectRow(at: indexPath, animated: false)
		}
    }
    
	// MARK: - Actions
	@IBAction func newAccountButtonClicked(_ sender: Any) {
        if !accountsTableView.isEditing
        {
            router?.navigateToNewAccount()
        }
		else
        {
            if let selectedRows = accountsTableView.indexPathsForSelectedRows
            {
                let request = AccountsModel.DeleteAccount.Request(indexPaths: selectedRows)
                interactor?.deleteAccount(request: request)
                accountsTableView.deleteRows(at: selectedRows, with: .automatic)
                self.editAccounts()
            }
            
        }
	}
	
	@IBAction func editButtonClicked(_ sender: Any) {
        editAccounts()
	}
	
}

// MARK: - TableView delegate
extension AccountsViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.accounts.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		accountsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UIAccountTableViewCell
		
		let account = viewModel?.accounts[indexPath.row]
		let index = indexPath.row
		
		accountsTableViewCell?.titleLabel.text = account?.title
		accountsTableViewCell?.dateOfCreationLabel.text = viewModel?.dateOfCreations[index]
		accountsTableViewCell?.iconImage.image = viewModel?.icons[index]
		accountsTableViewCell?.iconView.backgroundColor = viewModel?.colors[index]
        accountsTableViewCell?.balanceLabel.font = constants.roundedFont(18)
        accountsTableViewCell?.balanceLabel.textColor = viewModel?.accountsBalanceColor[index]
        
        let balanceStr = (viewModel?.accountsBalance[index] ?? "0") + " " + (viewModel?.currencies[index].symbol ?? "$")
        accountsTableViewCell?.balanceLabel.text = balanceStr
		
		return accountsTableViewCell!
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return (UIAccountTableViewCell.height)!
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !accountsTableView.isEditing else { return }
        selectedAccountIndexPath = indexPath
		let account = (viewModel?.accounts[indexPath.row])!
		router?.showOperations(account: account)
        saveSelectedIndex(indexPath)
	}
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal,
                                            title: NSLocalizedString("edit", comment: ""))
		{ (action, view, complitionHandler) in
            
            let account = self.viewModel?.accounts[indexPath.row]
            self.router?.navigateToEditAccount(account: account!)
            
        }
        editAction.backgroundColor = .systemBlue
        
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: NSLocalizedString("delete", comment: ""))
        { (action, view, complitionHandler) in
            let indexPaths = [indexPath]
            self.interactor?.deleteAccount(request: AccountsModel.DeleteAccount.Request(indexPaths: indexPaths))
            self.accountsTableView.deleteRows(at: indexPaths, with: .automatic)
            if self.selectedAccountIndexPath == indexPath && !self.splitViewController!.isCollapsed
            {
                self.router?.showOperations(account: nil)
            }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
	
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let request = AccountsModel.SwapAccount.Request(source: sourceIndexPath, destination: destinationIndexPath)
        interactor?.swapAccount(request: request)
    }
    
    func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        true
    }
    
}

// MARK: - Display accounts protocol
extension AccountsViewController: DisplayAccounts {
    
    func displaySwapAccounts(viewModel: AccountsModel.SwapAccount.ViewModel) {
        self.viewModel = viewModel.viewModel
        accountsTableView.reloadData()
    }
    
    func displayEditAccounts(viewModel: AccountsModel.EditAccounts.ViewModel) {
        btnEdit.setTitle(viewModel.editButtonTitle, for: .normal)
        btnNewAccount.setTitle(viewModel.newAccountButtonTitle, for: .normal)
        btnNewAccount.tintColor = viewModel.newAccountButtonColor
        btnNewAccount.setImage(viewModel.newAccountButtonImage, for: .normal)
    }
    
    func deletedAccount(viewModel: AccountsModel.DeleteAccount.ViewModel) {
        interactor?.requestAccounts()
    }
    
	func displayAccounts(viewModel: AccountsModel.ViewModel) {
		self.viewModel = viewModel
	}
}

// MARK: - NewAccount delegate
extension AccountsViewController: NewAccountDelegate {
	func accountDidCreate() {
		interactor?.requestAccounts()
		accountsTableView.reloadData()
        selectedAccountIndexPath = IndexPath(row: accountsTableView.numberOfRows(inSection: 0) - 1, section: 0)
        if !self.splitViewController!.isCollapsed
        {
            tableView(accountsTableView, didSelectRowAt: selectedAccountIndexPath)
        }
	}
}

// MARK: - EditAccount delegate
extension AccountsViewController: EditAccountDelegate
{
    func accountDidEdit() {
        interactor?.requestAccounts()
        accountsTableView.reloadData()
    }
    
}
