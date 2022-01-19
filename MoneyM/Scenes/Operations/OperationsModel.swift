//
//  OperationsModel.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import Foundation

class OperationsModel {
	
	struct Operations {
		struct Request {
			var account: AccountEntity
		}
		
		struct Response {
			var operations: [OperationEntity]
		}
		
		struct ViewModel {
			var operations: [OperationEntity]
		}
		
	}
	
	
}
