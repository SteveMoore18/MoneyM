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

        let response = OperationsModel.DeleteOperation.Response()
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
        
        // Grouping array by "dd MM yyyy"
        let groupedOperations = Dictionary(grouping: operations, by: { operation -> DateComponents in
            let date = Calendar.current.dateComponents([.day, .month, .year], from: operation.dateOfCreation!)
            return date
        })
        
        // Create array and sort by date
        var sortedGroupedOperations: [OperationsModel.OperationsGroupedByDateModel] = []
        groupedOperations.keys.forEach { key in
            let o = OperationsModel.OperationsGroupedByDateModel(date: key, operations: groupedOperations[key]!)
            sortedGroupedOperations.append(o)
        }
        
        sortedGroupedOperations = sortedGroupedOperations.sorted { i0, i1 in
            Calendar.current.date(from: i0.date)! > Calendar.current.date(from: i1.date)!
        }

        let response = OperationsModel.Operations.Response(operationsGroupedByDate: sortedGroupedOperations)
		presenter?.presentOperations(response: response)
	}
	
}
