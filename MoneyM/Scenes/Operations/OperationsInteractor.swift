//
//  OperationsInteractor.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import Foundation

protocol OperationsBusinessLogic {
	func requestOperations(request: OperationsModel.Operations.Request)
	func requestStatistics(request: OperationsModel.Statistics.Request)
}

class OperationsInteractor {
	
	var presenter: OperationsPresenter?
	
}

// MARK: - Operations business logic
extension OperationsInteractor: OperationsBusinessLogic {
	
	func requestStatistics(request: OperationsModel.Statistics.Request) {
		let worker = OperationsWorker()
		let (balance, expense, income) = worker.getStatistics(account: request.account)
		
//        let currencySymbol = request.account.cu
        
        let response = OperationsModel.Statistics.Response(currencySymbol: "",
                                                           balance: balance,
														   expense: expense,
														   income: income)
		
		presenter?.presentStatistics(response: response)
	}
	
	
	func requestOperations(request: OperationsModel.Operations.Request) {
		let worker = OperationsWorker()
		let operations = worker.operationsBy(account: request.account)
		let response = OperationsModel.Operations.Response(operations: operations)
		
		presenter?.presentOperations(response: response)
	}
	
}
