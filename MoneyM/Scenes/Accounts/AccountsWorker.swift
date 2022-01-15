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
	
	private func fetchRequest() {
		do {
			try accounts = context.fetch(AccountEntity.fetchRequest())
		} catch {
			print ("Error. Can't fetch accounts!")
		}
	}
	
}
