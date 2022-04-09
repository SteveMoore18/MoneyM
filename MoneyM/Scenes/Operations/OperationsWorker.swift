//
//  OperationsWorker.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import Foundation
import UIKit
import CoreData

class OperationsWorker {
	
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	
    init(account: AccountEntity) {
        
	}
    
    public func deleteOperation(operation: OperationEntity)
    {
        do
        {
            context.delete(operation)
            try context.save()
            
        } catch {
            print ("Error with saving deleted operation")
        }
    }
	
	public func getStatistics(account: AccountEntity) -> (balance: Int, expense: Int, income: Int)
	{
		
		var expense: Int = 0
		var income: Int = 0
        var balance: Int = Int(account.balance)
		
        let operations = fetchOperations(account: account)
		for operation in operations {
			let amount = Int(operation.amount)
			let mode = NewOperationModel.OperationMode(rawValue: Int(operation.mode))
			
			if mode == .Expense
			{
				expense += amount
			}
			else
			{
				income += amount
			}
		}
		expense = -expense
		balance += expense + income
		
		return (balance, expense, income)
	}
	
    public func fetchOperations(account: AccountEntity) -> [OperationEntity]
    {
        var operations = account.operations?.allObjects as! [OperationEntity]
        operations = operations.sorted { $0.dateOfCreation! > $1.dateOfCreation! }
        return operations
    }
    
}
