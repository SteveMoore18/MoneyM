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
	func showOperations(account: AccountEntity?)
    func navigateToEditAccount(account: AccountEntity)
}

class AccountsRouter {
	
	weak var viewController: AccountsViewController?
	
}

extension AccountsRouter: AccountsNavigate {
    func navigateToEditAccount(account: AccountEntity) {
        
        let storyboard = UIStoryboard(name: "NewAccount", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditAccountID") as! EditAccountViewController
        
        vc.account = account
        vc.editAccountDelegate = viewController
        
        viewController?.present(vc, animated: true)
        
    }
    
	func showOperations(account: AccountEntity?) {
		let storyboard = UIStoryboard(name: "Operations", bundle: nil)
		let operationsViewController = storyboard.instantiateViewController(withIdentifier: "Operations") as? OperationsViewController
		
		operationsViewController?.account = account
        operationsViewController?.accountViewController = viewController
		
		let navigationVC = UINavigationController(rootViewController: operationsViewController!)
		
		viewController?.splitViewController?.showDetailViewController(navigationVC, sender: nil)
	}
	
	func navigateToNewAccount() {
		
		let storyboard = UIStoryboard(name: "NewAccount", bundle: nil)
		let newAccountViewController = storyboard.instantiateViewController(withIdentifier: "NewAccountID") as? NewAccountViewController
		
		newAccountViewController?.newAccountDelegate = viewController
		
		viewController?.present(newAccountViewController!, animated: true)
	}
	
}
