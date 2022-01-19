//
//  OperationsInteractor.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import Foundation

protocol OperationsBusinessLogic {
	func requestOperations(request: OperationsModel.Operations.Request)
}

class OperationsInteractor {
	
	var presenter: OperationsPresenter?
	
}

// MARK: - Operations business logic
extension OperationsInteractor: OperationsBusinessLogic {
	
	func requestOperations(request: OperationsModel.Operations.Request) {
		let worker = OperationsWorker()
		let operations = worker.operationsBy(account: request.account)
		let response = OperationsModel.Operations.Response(operations: operations)
		
		presenter?.presentOperations(response: response)
	}
	
}
