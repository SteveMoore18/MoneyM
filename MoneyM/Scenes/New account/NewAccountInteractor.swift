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
	
}

class NewAccountInteractor {
	
	var presenter: NewAccountPresentLogic?
	
	// MARK: - Private variables
	private var worker: NewAccountWorker!
	
	// MARK: - Initialization
	init() {
		otherInit()
	}
	
	// MARK: - Private functions
	private func otherInit() {
		worker = NewAccountWorker()
	}
	
}

// MARK: - NewAccount business logic
extension NewAccountInteractor: NewAccountBusinesslogic {
	
	func requestColors() {
		let colors = worker.colors
		let response = NewAccountModel.Colors.Response(colors: colors)
		
		presenter?.presentColors(response: response)
	}
	
	func requestIcons() {
		let icons = worker.icons
		let response = NewAccountModel.Icons.Response(icons: icons)
		
		presenter?.presentIcons(response: response)
	}
	
}
