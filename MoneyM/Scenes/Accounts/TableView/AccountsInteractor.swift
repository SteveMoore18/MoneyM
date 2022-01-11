//
//  AccountsInteractor.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import Foundation

protocol AccountsBusinessLogic {
	func requestAccounts()
}

class AccountsInteractor {
	
	var presenter: AccountsPresentLogic?
	
	
}

extension AccountsInteractor: AccountsBusinessLogic {
	
	func requestAccounts() {
		let worker = AccountsWorker()
		let response = AccountsModel.Response(accounts: worker.accounts)
		
		presenter?.presentData(response: response)
	}
	
}
