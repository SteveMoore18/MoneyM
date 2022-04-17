//
//  CurrencyModel.swift
//  MoneyM
//
//  Created by Савелий Никулин on 14.01.2022.
//

import Foundation

class CurrencyModel {
	
	struct Model {
        var id: Int
		var symbol: String
		var title: String
		
		var all: String { "\(symbol) \(title)" }
		
        init(id: Int, symbol: String, title: String) {
            self.id = id
			self.symbol = symbol
			self.title = title
		}
	}
	
	private(set) var currencies: [Model] = []
	
	
	init() {
		initCurrencies()
	}
    
    public func currencyBy(id: Int) -> Model?
    {
        guard currencies.indices.contains(id) else {
            return nil
        }
        
        return currencies[id]
    }
	
	// MARK: - private functions
	private func initCurrencies() {
        currencies.append(Model(id: 0, symbol: "$", title: NSLocalizedString("dollar", comment: "")))
        currencies.append(Model(id: 1, symbol: "₽", title: NSLocalizedString("rouble", comment: "")))
	}
	
}
