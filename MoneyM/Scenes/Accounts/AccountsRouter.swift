//
//  AccountsRouter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 11.01.2022.
//

import Foundation
import UIKit

protocol AccountsNavigate: AnyObject {
	func navigateToNewAccount()
}

class AccountsRouter {
	
	weak var viewController: AccountsViewController?
	
}

extension AccountsRouter: AccountsNavigate {
	
	func navigateToNewAccount() {
		
		let storyboard = UIStoryboard(name: "NewAccount", bundle: nil)
		let newAccountViewController = storyboard.instantiateViewController(withIdentifier: "NewAccountID") as? NewAccountViewController
		
		viewController?.present(newAccountViewController!, animated: true)
	}
	
}
