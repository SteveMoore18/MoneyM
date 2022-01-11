//
//  UIView.swift
//  MoneyM
//
//  Created by Савелий Никулин on 11.01.2022.
//

import Foundation
import UIKit

extension UIView {
	
	@IBInspectable var cornerRadiusV: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}
	
}
