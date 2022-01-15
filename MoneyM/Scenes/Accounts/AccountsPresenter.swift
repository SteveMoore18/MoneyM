//
//  AccountsTableViewPresenter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import Foundation
import UIKit

protocol AccountsPresentLogic: AnyObject {
	func presentData(response: AccountsModel.Response)
}

class AccountsPresenter {
	
	weak var viewController: AccountsViewController?
	
	// MARK: - Private variables
	private var icons: Icons!
	private var colors: Colors!
	
	private var dateFormatter: DateFormatter!
	
	// MARK: - Init
	init() {
		icons = Icons()
		colors = Colors()
		
		dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM yyyy"
	}
	
}

extension AccountsPresenter: AccountsPresentLogic {
	
	func presentData(response: AccountsModel.Response) {
		
		let accounts = response.accounts
		let colorsArr: [UIColor] = accounts.map { colors.colors[Int($0.colorID)] }
		let iconsArr: [UIImage] = accounts.map { icons.icons[Int($0.iconID)] }
		let dateOfCreations: [String] = accounts.map { dateFormatter.string(from: $0.dateOfCreation!) }
		
		let viewModel = AccountsModel.ViewModel(colors: colorsArr,
												icons: iconsArr,
												dateOfCreations: dateOfCreations,
											    accounts: accounts)
		
		viewController?.displayAccounts(viewModel: viewModel)
	}
	
}
