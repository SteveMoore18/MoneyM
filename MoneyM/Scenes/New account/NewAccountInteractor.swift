//
//  NewAccountInteractor.swift
//  MoneyM
//
//  Created by Савелий Никулин on 11.01.2022.
//

import Foundation

protocol NewAccountBusinesslogic: AnyObject {
	func requestColors()
	func requestIcons()
	
	func createAccount(request: NewAccountModel.CreateAccount.Request)
}

class NewAccountInteractor {
	
	var presenter: NewAccountPresentLogic?
	
	// MARK: - Private variables
	private var worker: NewAccountWorker!
	
	private var icons: Icons!
	private var colors: Colors!
	
	// MARK: - Initialization
	init() {
		otherInit()
	}
	
	// MARK: - Private functions
	private func otherInit() {
		worker = NewAccountWorker()
		
		icons = Icons()
		colors = Colors()
	}
	
}

// MARK: - NewAccount business logic
extension NewAccountInteractor: NewAccountBusinesslogic {
	
	func createAccount(request: NewAccountModel.CreateAccount.Request) {
		worker.createAccount(request: request)
	}
	
	func requestColors() {
		let colors = colors.colors
		let response = NewAccountModel.Colors.Response(colors: colors)
		
		presenter?.presentColors(response: response)
	}
	
	func requestIcons() {
		let icons = icons.icons
		let response = NewAccountModel.Icons.Response(icons: icons)
		
		presenter?.presentIcons(response: response)
	}
	
}
