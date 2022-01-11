//
//  AccountsTableViewModel.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import Foundation

class AccountsModel {
	
	struct Account {
		var title: String
		var dateOfCreation: String
		var balance: String
	}
	
	struct Request {
		
	}
	
	struct Response {
		var accounts: [Account]
	}
	
	struct ViewModel {
		var accounts: [Account]
	}
	
}
