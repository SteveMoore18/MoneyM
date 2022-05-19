//
//  AccountsTableViewModel.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import Foundation
import UIKit

class AccountsModel {
	
	struct Account {
		var title: String
		var dateOfCreation: String
		var balance: String
	}
	
	struct Request {
		
	}
	
	struct Response {
		var accounts: [AccountEntity]
        var accountsBalance: [Int]
	}
	
	struct ViewModel {
        var accountsBalance: [String]
        var accountsBalanceColor: [UIColor]
		var colors: [UIColor]
		var icons: [UIImage]
		var dateOfCreations: [String]
        var currencies: [CurrencyModel.Model]
		var accounts: [AccountEntity]
	}
    
    struct DeleteAccount
    {
        struct Request
        {
            var indexPaths: [IndexPath]
        }
        
        struct Response { }
        
        struct ViewModel { }
    }
	
    struct SwapAccount
    {
        struct Request
        {
            var source: IndexPath
            var destination: IndexPath
        }
        
        struct Response
        {
            var source: IndexPath
            var destination: IndexPath
        }
        
        struct ViewModel
        {
            var viewModel: AccountsModel.ViewModel
        }
    }
    
    struct EditAccounts
    {
        struct Request
        {
            var isEditing: Bool
        }
        struct Response
        {
            var isEditing: Bool
            var editButtonTitle: String
            var newAccountButtonTitle: String
        }
        struct ViewModel
        {
            var isEditing: Bool
            var editButtonTitle: String
            var newAccountButtonTitle: String
            var newAccountButtonColor: UIColor
            var newAccountButtonImage: UIImage
        }
    }
}
