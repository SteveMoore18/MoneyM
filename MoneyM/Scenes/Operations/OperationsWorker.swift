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
	
	private(set) var operations: [OperationEntity] = []
	
    init(account: AccountEntity) {
        operations = fetchOperations(account: account)
	}
    
    public func deleteOperation(index: Int)
    {
        do
        {
            context.delete(operations[index])
            operations.remove(at: index)
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
        operations = account.operations?.allObjects as! [OperationEntity]
        return operations
    }
    
}
