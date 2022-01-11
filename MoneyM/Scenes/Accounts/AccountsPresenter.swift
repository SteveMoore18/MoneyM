//
//  AccountsTableViewPresenter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import Foundation

protocol AccountsPresentLogic: AnyObject {
	func presentData(response: AccountsModel.Response)
}

class AccountsPresenter {
	
	weak var viewController: AccountsViewController?
	
}

extension AccountsPresenter: AccountsPresentLogic {
	
	func presentData(response: AccountsModel.Response) {
		let viewModel = AccountsModel.ViewModel(accounts: response.accounts)
		
		viewController?.displayAccounts(viewModel: viewModel)
	}
	
}
