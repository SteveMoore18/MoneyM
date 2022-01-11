//
//  AccountsVC.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import UIKit

protocol DisplayAccounts: AnyObject {
	func displayAccounts(viewModel: AccountsModel.ViewModel)
}

class AccountsViewController: UIViewController {

	// MARK: - IBOutlets
	@IBOutlet weak var accountsTableView: UITableView!
	
	var interactor: AccountsBusinessLogic?
	var viewModel: AccountsModel.ViewModel?
	
	private var accountsTableViewCell: UIAccountTableViewCell?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		// CleanSwift setup
		setup()
		
		otherInit()
	}
	
	// MARK: - private functions
	private func setup() {
		
		let viewController = self
		let accountsInteractor = AccountsInteractor()
		let accountsPresenter = AccountsPresenter()
		
		accountsInteractor.presenter = accountsPresenter
		accountsPresenter.viewController = viewController
		
		interactor = accountsInteractor
		
	}
	
	private func otherInit() {
		interactor?.requestAccounts()
		
		accountsTableView.delegate = self
		accountsTableView.dataSource = self
		
		
		splitViewController?.minimumPrimaryColumnWidth = accountsTableView.frame.width
	}
    
	// MARK: - Actions
	@IBAction func newAccountButtonClicked(_ sender: Any) {
		
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
		
		accountsTableViewCell?.titleLabel.text = account?.title
		accountsTableViewCell?.dateOfCreationLabel.text = account?.dateOfCreation
		accountsTableViewCell?.balanceLabel.text = account?.balance
		
		return accountsTableViewCell!
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return (UIAccountTableViewCell.height)!
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
}

// MARK: - Display accounts protocol
extension AccountsViewController: DisplayAccounts {
	func displayAccounts(viewModel: AccountsModel.ViewModel) {
		self.viewModel = viewModel
	}
}
