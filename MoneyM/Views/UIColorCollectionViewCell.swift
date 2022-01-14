//
//  UIColorCollectionViewCell.swift
//  MoneyM
//
//  Created by Савелий Никулин on 14.01.2022.
//

import UIKit

class UIColorCollectionViewCell: UICollectionViewCell {
    
	@IBOutlet weak var selectedColorView: UIView!
	
	private let selectedColor: UIColor = .white
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	public func selectCell() {
		selectedColorView.backgroundColor = selectedColor
	}
	
	public func deselectCell() {
		selectedColorView.backgroundColor = contentView.backgroundColor
	}
	
}
