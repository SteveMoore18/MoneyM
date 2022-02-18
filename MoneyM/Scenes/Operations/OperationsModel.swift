//
//  OperationsModel.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import Foundation
import UIKit

class OperationsModel {
	
	struct OperationPresent {
		var operation: OperationEntity
		var amountColor: UIColor
		var amountValue: String
	}
	
	struct Operations {
		struct Request {
			var account: AccountEntity
		}
		
		struct Response {
			var operations: [OperationEntity]
		}
		
		struct ViewModel {
			var operations: [OperationPresent]
		}
		
	}
	
	struct Statistics
	{
		struct Request {
			var account: AccountEntity
		}
		
		struct Response
		{
            var currencySymbol: String
			var balance: Int
			var expense: Int
			var income: Int
		}
		
		struct ViewModel
		{
			var balanceColor: UIColor
			var balance: String
			var expense: String
			var income: String
		}
		
	}
	
}
