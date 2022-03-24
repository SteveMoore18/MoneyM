//
//  Colors.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import Foundation
import UIKit

class Colors {
	
	private(set) var colors: [UIColor] = []
	
	init() {
		initColors()
	}
	
	private func initColors() {
		colors.append(.systemBlue)
		colors.append(.systemRed)
		colors.append(.systemGreen)
		colors.append(.systemGray)
		colors.append(.systemOrange)
		colors.append(.systemIndigo)
		colors.append(.systemPurple)
		colors.append(.systemYellow)
	}
	
}
