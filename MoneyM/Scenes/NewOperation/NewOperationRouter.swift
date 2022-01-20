//
//  NewOperationRouter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 19.01.2022.
//

import Foundation
import UIKit

protocol NewOperationNavigate: AnyObject {
	func navigateToCategory(mode: NewOperationModel.OperationMode)
}

class NewOperationRouter {
	
	weak var viewController: NewOperationViewController?
	
}

// MARK: - NewOperation Navigate
extension NewOperationRouter: NewOperationNavigate {
	
	func navigateToCategory(mode: NewOperationModel.OperationMode) {
		let storyboard = UIStoryboard(name: "NewOperation", bundle: nil)
		let categoryViewController = storyboard.instantiateViewController(withIdentifier: "Category") as? CategoryViewController
		
		categoryViewController?.operationMode = mode
		categoryViewController?.delegate = viewController
		categoryViewController?.categoryModel = viewController?.categoryModel
		
		viewController?.present(categoryViewController!, animated: true)
	}
	
}
