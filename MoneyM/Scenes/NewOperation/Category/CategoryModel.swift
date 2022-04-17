//
//  CategoryModel.swift
//  MoneyM
//
//  Created by Савелий Никулин on 19.01.2022.
//

import Foundation

class CategoryModel {
	
	struct Model {
		var id: Int
		var emojiIcon: String
		var title: String
	}
	
	private(set) var expenseCategories: [Model] = []
	private(set) var incomeCategories: [Model] = []
	
	private(set) var categoryUncategorized: Model!
	
	init() {
        
        appendCategory(&incomeCategories, "🚫", NSLocalizedString("uncategorized", comment: ""))
        appendCategory(&incomeCategories, "💰", NSLocalizedString("salary", comment: ""))
        appendCategory(&incomeCategories, "🪙", NSLocalizedString("part_time_job", comment: ""))
        
        appendCategory(&expenseCategories, "🚫", NSLocalizedString("uncategorized", comment: ""))
        appendCategory(&expenseCategories, "🍉", NSLocalizedString("food", comment: ""))
        appendCategory(&expenseCategories, "🕹", NSLocalizedString("entertaiment", comment: ""))
        appendCategory(&expenseCategories, "🚗", NSLocalizedString("car", comment: ""))
        appendCategory(&expenseCategories, "🚌", NSLocalizedString("transport", comment: ""))
        appendCategory(&expenseCategories, "💊", NSLocalizedString("health", comment: ""))
        appendCategory(&expenseCategories, "🖥", NSLocalizedString("technology", comment: ""))
        appendCategory(&expenseCategories, "📱", NSLocalizedString("communication", comment: ""))
        appendCategory(&expenseCategories, "🌐", NSLocalizedString("internet", comment: ""))
        appendCategory(&expenseCategories, "👕", NSLocalizedString("clothes", comment: ""))
        appendCategory(&expenseCategories, "🐱", NSLocalizedString("pet", comment: ""))
        appendCategory(&expenseCategories, "🏠", NSLocalizedString("house_and_utilities", comment: ""))
        appendCategory(&expenseCategories, "💡", NSLocalizedString("electricity", comment: ""))
        appendCategory(&expenseCategories, "🔥", NSLocalizedString("gas", comment: ""))
        appendCategory(&expenseCategories, "💸", NSLocalizedString("payment_of_debts", comment: ""))
        
		categoryUncategorized = expenseCategories[0]
		
	}
	
	public func categories(mode: NewOperationModel.OperationMode) -> [Model] {
		switch mode {
			case .Expense:
				return expenseCategories
			case .Income:
				return incomeCategories
		}
	}
	
	public func categoryBy(id: Int) -> Model? {
		
		if let incomeRes = incomeCategories.first(where: { $0.id == id }) {
			return incomeRes
		}
		
		if let expenseRes = expenseCategories.first(where: { $0.id == id }) {
			return expenseRes
		}
		
		
		return nil
	}
	
	// MARK: - Private functions
	private func appendCategory(_ array: inout [Model], _ icon: String, _ localizedKey: String) {
		let id = ("\(icon) \(localizedKey)").hash
		let category = Model(id: id, emojiIcon: icon, title: localizedKey)
		array.append(category)
	}
	
}
