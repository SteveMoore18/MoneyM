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
    func navigateToOperationsChart(data: OperationsPieChartModel.Data)
}

class OperationsRouter {
	
	weak var viewController: OperationsViewController?
	
}

// MARK: - Operations Navigate
extension OperationsRouter: OperationNavigate {
    
    func navigateToOperationsChart(data: OperationsPieChartModel.Data) {
        let storyboard = UIStoryboard(name: "OperationsPieChart", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "OperationPieChartID") as! OperationsPieChartViewController

        vc.data = data

        viewController?.present(vc, animated: true)
    }
	
	func navigateToNewOperation() {
		
		let storyboard = UIStoryboard(name: "NewOperation", bundle: nil)
		let newOperationViewController = storyboard.instantiateViewController(withIdentifier: "NewOperation") as? NewOperationViewController
		
		newOperationViewController?.account = viewController?.account
		newOperationViewController?.delegate = viewController
		newOperationViewController?.categoryModel = viewController?.categoryModel
		
		viewController?.present(newOperationViewController!, animated: true)
	}
	
}
