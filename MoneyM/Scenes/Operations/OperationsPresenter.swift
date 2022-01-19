//
//  OperationsPresenter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import Foundation

protocol OperationsPresenterLogic {
	func presentOperations(response: OperationsModel.Operations.Response)
}

class OperationsPresenter {
	
	weak var viewController: OperationsViewController?
	
}

// MARK: - Operations presenter logic
extension OperationsPresenter: OperationsPresenterLogic {
	
	func presentOperations(response: OperationsModel.Operations.Response) {
		let viewModel = OperationsModel.Operations.ViewModel(operations: response.operations)
		viewController?.displayOperation(viewModel: viewModel)
	}
	
}
