//
//  NewOperationInteractor.swift
//  MoneyM
//
//  Created by Савелий Никулин on 19.01.2022.
//

import Foundation

protocol NewOperationBusinessLogic {
	func createOperation(request: NewOperationModel.CreateOperation.Request)
}

class NewOperationInteractor {
	
	var presenter: NewOperationPresentLogic?
	
}

extension NewOperationInteractor: NewOperationBusinessLogic {
	
	func createOperation(request: NewOperationModel.CreateOperation.Request) {
		let worker = NewOperationWorker()
		worker.createAccount(request: request)
		
		let response = NewOperationModel.CreateOperation.Response(success: true)
		presenter?.presentResult(response: response)
	}
	
}
