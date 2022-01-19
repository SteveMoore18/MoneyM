//
//  OperationsRouter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 18.01.2022.
//

import Foundation
import UIKit

protocol OperationNavigate: AnyObject {
	func navigateToNewOperation()
}

class OperationsRouter {
	
	weak var viewController: OperationsViewController?
	
}

// MARK: - Operations Navigate
extension OperationsRouter: OperationNavigate {
	
	func navigateToNewOperation() {
		
		let storyboard = UIStoryboard(name: "NewOperation", bundle: nil)
		let newOperationViewController = storyboard.instantiateViewController(withIdentifier: "NewOperation") as? NewOperationViewController
		
		newOperationViewController?.account = viewController?.account
		newOperationViewController?.delegate = viewController
		
		viewController?.present(newOperationViewController!, animated: true)
	}
	
}
