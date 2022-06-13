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
    func expenseViewClicked(requst: OperationsModel.ChartsData.Request)
    func incomeViewClicked(request: OperationsModel.ChartsData.Request)
}

class OperationsInteractor {
	
	var presenter: OperationsPresenter?
    
    private var worker: OperationsWorker!
	
    private var sortedOperationsByDate: [OperationsModel.OperationsGroupedByDateModel] = []
    
    init(account: AccountEntity)
    {
        worker = OperationsWorker(account: account)
    }
}

// MARK: - Operations business logic
extension OperationsInteractor: OperationsBusinessLogic {
    
    func incomeViewClicked(request: OperationsModel.ChartsData.Request)
    {
        let operationsWithoutExpenses = request.operations.filter { operation in
            let mode = NewOperationModel.OperationMode(rawValue: Int(operation.mode))
            return mode == .Income
        }
        
        let response = OperationsModel.ChartsData.Response(operations: operationsWithoutExpenses)
        presenter?.presentIncomeChart(response: response)
    }
    
    func expenseViewClicked(requst: OperationsModel.ChartsData.Request)
    {
        let operationsWithoutIncomes = requst.operations.filter { operation in
            let mode = NewOperationModel.OperationMode(rawValue: Int(operation.mode))
            return mode == .Expense
        }
        
        let response = OperationsModel.ChartsData.Response(operations: operationsWithoutIncomes)
        presenter?.presentExpenseChart(response: response)
    }
    
    func deleteOperation(request: OperationsModel.DeleteOperation.Request) {
        let operation = sortedOperationsByDate[request.indexPath.section].operations[request.indexPath.row]
        worker.deleteOperation(operation: operation)
        
        let response = OperationsModel.DeleteOperation.Response(indexPath: request.indexPath)
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
        sortedOperationsByDate.removeAll()
        groupedOperations.keys.forEach { key in
            let o = OperationsModel.OperationsGroupedByDateModel(date: key, operations: groupedOperations[key]!)
            sortedOperationsByDate.append(o)
        }
        
        sortedOperationsByDate = sortedOperationsByDate.sorted { i0, i1 in
            Calendar.current.date(from: i0.date)! > Calendar.current.date(from: i1.date)!
        }

        let response = OperationsModel.Operations.Response(operationsGroupedByDate: sortedOperationsByDate)
		presenter?.presentOperations(response: response)
	}
	
}
