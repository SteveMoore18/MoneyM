//
//  OperationsWorker.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import Foundation
import UIKit

class OperationsWorker {
	
	private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	private(set) var operations: [OperationEntity] = []
	
	init() {
		
	}
	
	public func operationsBy(account: AccountEntity) -> [OperationEntity] {
		
		operations = account.operations?.allObjects as! [OperationEntity]
		
		return operations
	}
	
	public func getStatistics(account: AccountEntity) -> (balance: Int, expense: Int, income: Int)
	{
		operations = account.operations?.allObjects as! [OperationEntity]
		
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
	
}
