//
//  AccountsVC.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import UIKit

protocol DisplayAccounts: AnyObject {
	func displayAccounts(viewModel: AccountsModel.ViewModel)
    func deletedAccount(viewModel: AccountsModel.DeleteAccount.ViewModel)
}

class AccountsViewController: UIViewController {

	// MARK: - IBOutlets
	@IBOutlet weak var accountsTableView: UITableView!
	
    @IBOutlet weak var newAccountButton: UIButton!
    
    var interactor: AccountsBusinessLogic?
	var router: AccountsNavigate?
	var viewModel: AccountsModel.ViewModel?
	
	private var accountsTableViewCell: UIAccountTableViewCell?
    
    private var constants: Constants!
	
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
			accountsTableView.selectRow(at: IndexPath(row: 0, section: 0),
										animated: true, scrollPosition: .none)
			let account = (viewModel?.accounts[0])!
			router?.showOperations(account: account)
		}
        constants = Constants()
        newAccountButton.titleLabel?.font = constants.roundedFont(20)
	}
    
	// MARK: - Actions
	@IBAction func newAccountButtonClicked(_ sender: Any) {
		router?.navigateToNewAccount()
	}
	
	@IBAction func editButtonClicked(_ sender: Any) {
		
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
        accountsTableViewCell?.balanceLabel.text = viewModel?.accountsBalance[index]
		accountsTableViewCell?.iconImage.image = viewModel?.icons[index]
		accountsTableViewCell?.iconView.backgroundColor = viewModel?.colors[index]
        accountsTableViewCell?.balanceLabel.font = constants.roundedFont(20)
        accountsTableViewCell?.balanceLabel.textColor = viewModel?.accountsBalanceColor[index]
		
		return accountsTableViewCell!
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return (UIAccountTableViewCell.height)!
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let account = (viewModel?.accounts[indexPath.row])!
		router?.showOperations(account: account)
	}
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Delete")
        { (action, view, complitionHandler) in
            self.interactor?.deleteAccount(request: AccountsModel.DeleteAccount.Request(index: indexPath.row))
            self.accountsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
	
}

// MARK: - Display accounts protocol
extension AccountsViewController: DisplayAccounts {
    
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
	}
}
