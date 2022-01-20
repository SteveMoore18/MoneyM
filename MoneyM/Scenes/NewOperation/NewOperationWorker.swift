//
//  NewOperationWorker.swift
//  MoneyM
//
//  Created by Савелий Никулин on 19.01.2022.
//

import Foundation
import UIKit

class NewOperationWorker {
	
	private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	public func createAccount(request: NewOperationModel.CreateOperation.Request) {
		
		let newOperation = OperationEntity(context: context)
		newOperation.amount = Int64(request.amount)
		newOperation.mode = Int64(request.mode.rawValue)
		newOperation.note = request.note
		newOperation.dateOfCreation = request.dateOfCreation
		newOperation.categoryID = Int64(request.categoryID)
		
		request.account.addToOperations(newOperation)
		
		do {
			try context.save()
		} catch {
			print ("Error! Can't create operation!")
		}
		
	}
	
	// MARK: - Private functions
	
	
}
