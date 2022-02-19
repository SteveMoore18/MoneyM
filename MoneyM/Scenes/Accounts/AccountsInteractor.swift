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
        let accounts = worker.accounts
        var accountsBalance: [Int] = []
        
        // Counting balance on each account
        for account in accounts
        {
            var balance = Int(account.balance)
            for operation in account.operations?.allObjects as! [OperationEntity]
            {
                let amount = Int(operation.amount)
                let mode = NewOperationModel.OperationMode(rawValue: Int(operation.mode))
                
                let sign = (mode == .Expense ? -1 : 1)
                balance += (amount * sign)
            }
            accountsBalance.append(balance)
        }
        
		let response = AccountsModel.Response(accounts: accounts,
                                              accountsBalance: accountsBalance)
		
		presenter?.presentData(response: response)
	}
	
}
