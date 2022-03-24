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
    
    func deletedOperation(response: OperationsModel.DeleteOperation.Response) {
        let operations = beautyOperation(operations: response.operations)
        let viewModel = OperationsModel.DeleteOperation.ViewModel(operations: operations)
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
		
        let operations = beautyOperation(operations: response.operations)
		
		let viewModel = OperationsModel.Operations.ViewModel(operations: operations)
		viewController?.displayOperation(viewModel: viewModel)
	}
	
}
