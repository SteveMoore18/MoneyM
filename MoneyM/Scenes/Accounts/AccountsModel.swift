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
		var accounts: [AccountEntity]
	}
    
    struct DeleteAccount
    {
        struct Request
        {
            var index: Int
        }
        
        struct Response { }
        
        struct ViewModel { }
    }
	
}
