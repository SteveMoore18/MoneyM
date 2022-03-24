//
//  NewAccountPresenter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 11.01.2022.
//

import Foundation

protocol NewAccountPresentLogic: AnyObject {
	func presentColors(response: NewAccountModel.Colors.Response)
	func presentIcons(response: NewAccountModel.Icons.Response)
	
}

class NewAccountPresenter {
	
	weak var viewControlller: NewAccountViewController?
	
}

// MARK: - NewAccount present logic
extension NewAccountPresenter: NewAccountPresentLogic {
	
	func presentColors(response: NewAccountModel.Colors.Response) {
		let viewModel = NewAccountModel.Colors.ViewModel(colors: response.colors)
		
		viewControlller?.displayColors(viewModel: viewModel)
	}
	
	func presentIcons(response: NewAccountModel.Icons.Response) {
		let viewModel = NewAccountModel.Icons.ViewModel(icons: response.icons)
		
		viewControlller?.displayIcons(viewModel: viewModel)
	}
	
}
