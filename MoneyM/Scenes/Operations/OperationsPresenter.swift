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
}

class OperationsPresenter {
	
	weak var viewController: OperationsViewController?
	
}

// MARK: - Operations presenter logic
extension OperationsPresenter: OperationsPresenterLogic {
	
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
		
		var operations: [OperationsModel.OperationPresent] = []
		
		response.operations.forEach { operation in
			let mode = NewOperationModel.OperationMode.init(rawValue: Int(operation.mode))
			let amount = operation.amount
			
			let amountColor = (mode == .Expense) ? UIColor.systemRed : UIColor.systemBlue
			let amountValue = (mode == .Expense) ? "-\(amount)" : "+\(amount)"
			
			operations.append(OperationsModel.OperationPresent(operation: operation,
															   amountColor: amountColor,
															   amountValue: amountValue))
		}
		
		let viewModel = OperationsModel.Operations.ViewModel(operations: operations)
		viewController?.displayOperation(viewModel: viewModel)
	}
	
}
