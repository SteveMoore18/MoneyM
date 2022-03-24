//
//  NewOperationPresenter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 19.01.2022.
//

import Foundation

protocol NewOperationPresentLogic {
	func presentResult(response: NewOperationModel.CreateOperation.Response)
}

class NewOperationPresenter {
	
	weak var viewController: NewOperationViewController?
	
}

extension NewOperationPresenter: NewOperationPresentLogic {
	func presentResult(response: NewOperationModel.CreateOperation.Response) {
		let viewModel = NewOperationModel.CreateOperation.ViewModel(success: true)
		viewController?.displayResult(viewModel: viewModel)
	}
	
}
