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
    func deletedAccount(response: AccountsModel.DeleteAccount.Response)
    func presentEditAccounts(response: AccountsModel.EditAccounts.Response)
    func swapAccount(response: AccountsModel.SwapAccount.Response)
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
    
    func swapAccount(response: AccountsModel.SwapAccount.Response) {
        var viewModel = AccountsModel.SwapAccount.ViewModel(viewModel: (viewController?.viewModel)!)
        let i = response.source.row
        let j = response.destination.row
        
        viewModel.viewModel.accounts.swapAt(i, j)
        viewModel.viewModel.accountsBalance.swapAt(i, j)
        viewModel.viewModel.accountsBalanceColor.swapAt(i, j)
        viewModel.viewModel.colors.swapAt(i, j)
        viewModel.viewModel.icons.swapAt(i, j)
        viewModel.viewModel.dateOfCreations.swapAt(i, j)
        viewModel.viewModel.currencies.swapAt(i, j)
        
        viewController?.displaySwapAccounts(viewModel: viewModel)
    }
    
    func presentEditAccounts(response: AccountsModel.EditAccounts.Response)
    {
        let editButtonTitle = response.editButtonTitle
        let newAccountButtonTitle = response.newAccountButtonTitle
        let newAccountButtonColor: UIColor = response.isEditing ? .systemRed : .systemBlue
        let newAccountButtonImage = UIImage(systemName: response.isEditing ? "trash" : "plus.circle")
        
        let viewModel = AccountsModel.EditAccounts.ViewModel(isEditing: response.isEditing,
                                                             editButtonTitle: editButtonTitle,
                                                             newAccountButtonTitle: newAccountButtonTitle,
                                                             newAccountButtonColor: newAccountButtonColor,
                                                             newAccountButtonImage: newAccountButtonImage!)
        
        viewController?.displayEditAccounts(viewModel: viewModel)
    }
    
    func deletedAccount(response: AccountsModel.DeleteAccount.Response) {
        viewController?.deletedAccount(viewModel: AccountsModel.DeleteAccount.ViewModel())
    }
    
	func presentData(response: AccountsModel.Response) {
		
        let currencyModel = CurrencyModel()
        
		let accounts = response.accounts
		let colorsArr: [UIColor] = accounts.map { colors.colors[Int($0.colorID)] }
		let iconsArr: [UIImage] = accounts.map { icons.icons[Int($0.iconID)] }
		let dateOfCreations: [String] = accounts.map { dateFormatter.string(from: $0.dateOfCreation!) }
        let accountsBalance = response.accountsBalance.map { String($0) }
        let accountsBalanceColor = response.accountsBalance.map {
            Int($0) < 0 ? UIColor.systemRed : UIColor.systemBlue
        }
        let currencies = response.accounts.map { currencyModel.currencyBy(id: Int($0.currencyID))! }
        
        let viewModel = AccountsModel.ViewModel(accountsBalance: accountsBalance,
                                                accountsBalanceColor: accountsBalanceColor,
                                                colors: colorsArr,
												icons: iconsArr,
                                                dateOfCreations: dateOfCreations,
                                                currencies: currencies,
											    accounts: accounts)
		
		viewController?.displayAccounts(viewModel: viewModel)
	}
	
}
