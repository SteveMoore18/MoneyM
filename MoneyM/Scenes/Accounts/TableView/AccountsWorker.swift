//
//  AccountsTableViewWorker.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import Foundation

class AccountsWorker {
	
	public var accounts: [AccountsModel.Account] = []
	
	init() {
		accounts.append(.init(title: "Test 1", dateOfCreation: "01.01.2000", balance: "1000 $"))
		accounts.append(.init(title: "Test 2", dateOfCreation: "09.12.2015", balance: "1500 $"))
		
	}
	
}
