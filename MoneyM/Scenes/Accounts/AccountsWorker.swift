//
//  AccountsTableViewWorker.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import Foundation
import UIKit

class AccountsWorker {
	
	public var accounts: [AccountEntity] = []
	
	private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	init() {
		fetchRequest()
	}
    
    public func deleteAccount(index: Int)
    {
        do
        {
            context.delete(accounts[index])
            try context.save()
        } catch { }
        
    }
    
    public func swapAccount(request: AccountsModel.SwapAccount.Request)
    {
        accounts.swapAt(request.source.row, request.destination.row)
        for (index, acc) in accounts.enumerated() {
            acc.index = Int64(index)
        }
        save()
    }
	
    // Private functions
	private func fetchRequest() {
		do {
			try accounts = context.fetch(AccountEntity.fetchRequest())
            
            accounts = accounts.sorted { $0.index < $1.index }
            
		} catch {
			print ("Error. Can't fetch accounts!")
		}
	}
	
    private func save()
    {
        do
        {
            try context.save()
        } catch {
            print ("Error. Can't save accounts!")
        }
    }
}
