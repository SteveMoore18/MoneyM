//
//  Constant.swift
//  MoneyM
//
//  Created by Савелий Никулин on 14.01.2022.
//

import Foundation
import UIKit

class Constants {
	
	public lazy var roundedFont = { (size: CGFloat) -> UIFont in
		let font = UIFont(name: "SFRounded-Medium", size: size)
		return font!
	}
	
	public lazy var defaultCurrency = { () -> CurrencyModel.Model in
		let currencyModel = CurrencyModel()
		let currency = currencyModel.currencies[0]
		return currency
	}
	
}
