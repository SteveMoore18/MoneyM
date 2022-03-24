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
    func deleteOperation(request: OperationsModel.DeleteOperation.Request)
}

class OperationsInteractor {
	
	var presenter: OperationsPresenter?
    
    private var worker: OperationsWorker!
	
    init(account: AccountEntity)
    {
        worker = OperationsWorker(account: account)
    }
}

// MARK: - Operations business logic
extension OperationsInteractor: OperationsBusinessLogic {
    
    func deleteOperation(request: OperationsModel.DeleteOperation.Request) {
        worker.deleteOperation(index: request.index)

        let response = OperationsModel.DeleteOperation.Response(operations: worker.operations)
        presenter?.deletedOperation(response: response)
    }
	
	func requestStatistics(request: OperationsModel.Statistics.Request) {
        let worker = OperationsWorker(account: request.account)
		let (balance, expense, income) = worker.getStatistics(account: request.account)
		
//        let currencySymbol = request.account.cu
        
        let response = OperationsModel.Statistics.Response(currencySymbol: "",
                                                           balance: balance,
														   expense: expense,
														   income: income)
		
		presenter?.presentStatistics(response: response)
	}
	
	
	func requestOperations(request: OperationsModel.Operations.Request) {
        let operations = worker.fetchOperations(account: request.account)
        let response = OperationsModel.Operations.Response(operations: operations)
		
		presenter?.presentOperations(response: response)
	}
	
}
