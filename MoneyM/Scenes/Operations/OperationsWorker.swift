//
//  OperationsWorker.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import Foundation
import UIKit

class OperationsWorker {
	
	private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	private(set) var operations: [OperationEntity] = []
	
	init() {
		
	}
	
	public func operationsBy(account: AccountEntity) -> [OperationEntity] {
		
		operations = account.operations?.allObjects as! [OperationEntity]
		
		return operations
	}
	
}
