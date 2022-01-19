//
//  NewOperationModel.swift
//  MoneyM
//
//  Created by Савелий Никулин on 19.01.2022.
//

import Foundation

class NewOperationModel {
	
	enum OperationMode: Int {
		case Expense = 0
		case Income = 1
	}
	
	struct CreateOperation {
		
		struct Request {
			var account: AccountEntity
			var amount: Int
			var mode: OperationMode
			var category: String
			var note: String
			var dateOfCreation: Date
		}
		
		struct Response {
			var success: Bool
		}
		
		struct ViewModel {
			var success: Bool
		}
		
	}
	
}
