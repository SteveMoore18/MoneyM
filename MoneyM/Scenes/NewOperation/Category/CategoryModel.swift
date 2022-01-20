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
		
		appendCategory(&incomeCategories, "🚫", "Uncategorized")
		appendCategory(&incomeCategories, "💰", "Salary")
		appendCategory(&incomeCategories, "🪙", "Part time job")
		
		appendCategory(&expenseCategories, "🚫", "Uncategorized")
		appendCategory(&expenseCategories, "🍉", "Food")
		appendCategory(&expenseCategories, "🕹", "Entertaiment")
		appendCategory(&expenseCategories, "🚗", "Car")
		appendCategory(&expenseCategories, "🚌", "Transport")
		appendCategory(&expenseCategories, "💊", "Health")
		appendCategory(&expenseCategories, "🖥", "Technology")
		appendCategory(&expenseCategories, "📱", "Communication")
		appendCategory(&expenseCategories, "🌐", "Internet")
		appendCategory(&expenseCategories, "👕", "Clothes")
		appendCategory(&expenseCategories, "🐱", "Pet")
		appendCategory(&expenseCategories, "🏠", "House and utilities")
		appendCategory(&expenseCategories, "💡", "Electricity")
		appendCategory(&expenseCategories, "🔥", "Gas")
		appendCategory(&expenseCategories, "💸", "Payment of debts")

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
