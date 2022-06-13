//
//  OperationsPresenter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import Foundation
import UIKit

protocol OperationsPresenterLogic {
	func presentOperations(response: OperationsModel.Operations.Response)
	func presentStatistics(response: OperationsModel.Statistics.Response)
    func deletedOperation(response: OperationsModel.DeleteOperation.Response)
    func presentExpenseChart(response: OperationsModel.ChartsData.Response)
    func presentIncomeChart(response: OperationsModel.ChartsData.Response)
}

class OperationsPresenter {
	
	weak var viewController: OperationsViewController?
	
    private func beautyOperation(operations: [OperationEntity]) -> [OperationsModel.OperationPresent]
    {
        var resultOperations: [OperationsModel.OperationPresent] = []
        
        operations.forEach { operation in
            let mode = NewOperationModel.OperationMode.init(rawValue: Int(operation.mode))
            let amount = operation.amount
            
            let amountColor = (mode == .Expense) ? UIColor.systemRed : UIColor.systemBlue
            let amountValue = (mode == .Expense) ? "-\(amount)" : "+\(amount)"
            
            resultOperations.append(OperationsModel.OperationPresent(operation: operation,
                                                               amountColor: amountColor,
                                                               amountValue: amountValue))
        }
        
        return resultOperations
    }
}

// MARK: - Operations presenter logic
extension OperationsPresenter: OperationsPresenterLogic {
    
    func presentIncomeChart(response: OperationsModel.ChartsData.Response)
    {
        let viewModel = OperationsModel.ChartsData.ViewModel(operations: response.operations)
        viewController?.displayIncomeChart(viewModel: viewModel)
    }
    
    func presentExpenseChart(response: OperationsModel.ChartsData.Response)
    {
        let viewModel = OperationsModel.ChartsData.ViewModel(operations: response.operations)
        viewController?.displayExpenseChart(viewModel: viewModel)
    }
    
    func deletedOperation(response: OperationsModel.DeleteOperation.Response) {
        let viewModel = OperationsModel.DeleteOperation.ViewModel(indexPath: response.indexPath)
        viewController?.deletedOperation(viewModel: viewModel)
    }
	
	func presentStatistics(response: OperationsModel.Statistics.Response) {
		
		let balance = response.balance
		let balanceColor: UIColor = balance < 0 ? .systemRed : .systemBlue
        let strBalance = String(balance) + ""
		
		let viewModel = OperationsModel.Statistics.ViewModel(balanceColor: balanceColor,
															 balance: strBalance,
															 expense: String(response.expense),
															 income: String(response.income))
		
		viewController?.displayStatistics(viewModel: viewModel)
	}
	
	
	func presentOperations(response: OperationsModel.Operations.Response) {
		
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        
        var dates: [String] = []
        var operations: [[OperationsModel.OperationPresent]] = []
        
        for item in response.operationsGroupedByDate
        {
            let date = Calendar.current.date(from: item.date)
            dates.append(formatter.string(from: date!))
            
            operations.append(beautyOperation(operations: item.operations))
        }
        
        let viewModel = OperationsModel.Operations.ViewModel(dates: dates,
                                                             operations: operations)
        viewController?.displayOperation(viewModel: viewModel)
	}
	
}
