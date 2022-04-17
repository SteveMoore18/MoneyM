//
//  AccountsInteractor.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import Foundation

protocol AccountsBusinessLogic {
	func requestAccounts()
    func deleteAccount(request: AccountsModel.DeleteAccount.Request)
    func swapAccount(request: AccountsModel.SwapAccount.Request)
    func editAccounts(request: AccountsModel.EditAccounts.Request)
}

class AccountsInteractor {
	
	var presenter: AccountsPresentLogic?
	
    
    
	init()
    {
        
    }
    
}

extension AccountsInteractor: AccountsBusinessLogic {
    
    func editAccounts(request: AccountsModel.EditAccounts.Request)
    {
        let editButtonTitle = request.isEditing ? NSLocalizedString("done", comment: "")
            : NSLocalizedString("edit", comment: "")
        
        let newAccountButtonTitle = request.isEditing ? NSLocalizedString("delete", comment: "")
            : NSLocalizedString("new_account", comment: "")
        
        let response = AccountsModel.EditAccounts.Response(isEditing: request.isEditing,
                                                           editButtonTitle: editButtonTitle,
                                                           newAccountButtonTitle: newAccountButtonTitle)
        
        presenter?.presentEditAccounts(response: response)
    }
    
    func swapAccount(request: AccountsModel.SwapAccount.Request) {
        let worker = AccountsWorker()
        worker.swapAccount(request: request)
    }
    
    func deleteAccount(request: AccountsModel.DeleteAccount.Request) {
        let worker = AccountsWorker()
        for indexPath in request.indexPaths
        {
            worker.deleteAccount(index: indexPath.row)
        }
        
        
        presenter?.deletedAccount(response: AccountsModel.DeleteAccount.Response())
    }
	
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
