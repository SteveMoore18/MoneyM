//
//  CurrencyModel.swift
//  MoneyM
//
//  Created by Савелий Никулин on 14.01.2022.
//

import Foundation

class CurrencyModel {
	
	struct Model {
		var symbol: String
		var title: String
		
		var all: String { "\(symbol) \(title)" }
		
		init(symbol: String, title: String) {
			self.symbol = symbol
			self.title = title
		}
	}
	
	private(set) var currencies: [Model] = []
	
	
	init() {
		initCurrencies()
	}
	
	// MARK: - private functions
	private func initCurrencies() {
		currencies.append(Model(symbol: "$", title: "Dollar"))
		currencies.append(Model(symbol: "₽", title: "Russian rouble"))
	}
	
}
