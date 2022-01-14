//
//  NewAccountsRouter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 14.01.2022.
//

import Foundation
import UIKit

protocol NewAccountNavigate {
	func navigateToCurrency()
}

class NewAccountRouter {
	
	weak var viewController: UIViewController?
	
}

extension NewAccountRouter: NewAccountNavigate {
	
	func navigateToCurrency() {
		let storyboard = UIStoryboard(name: "NewAccount", bundle: nil)
		let currencyViewController = storyboard.instantiateViewController(withIdentifier: "Currency") as? CurrencyViewController
		
		currencyViewController!.delegate = viewController as? CurrencyDelegate
		
		viewController?.present(currencyViewController!, animated: true)
	}
	
	
}
