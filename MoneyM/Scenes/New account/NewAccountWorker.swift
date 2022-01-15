//
//  NewAccountWorker.swift
//  MoneyM
//
//  Created by Савелий Никулин on 11.01.2022.
//

import Foundation
import UIKit

class NewAccountWorker {
	
	private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	init() {
		
	}
	
	public func createAccount(request: NewAccountModel.CreateAccount.Request) {
		let newAccount = AccountEntity(context: context)
		newAccount.title = request.title
		newAccount.balance = Int64(request.balance)
		newAccount.colorID = Int64(request.colorID)
		newAccount.iconID = Int64(request.iconID)
		newAccount.dateOfCreation = Date()
		
		save()
	}
	
	// MARK: - Private functions
	private func save() {
		do {
			try context.save()
		} catch {
			print ("Error. Can't save accounts.")
		}
	}
}
