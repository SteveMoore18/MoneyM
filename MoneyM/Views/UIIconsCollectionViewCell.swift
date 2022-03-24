//
//  UIIconsCollectionViewCell.swift
//  MoneyM
//
//  Created by Савелий Никулин on 11.01.2022.
//

import UIKit

class UIIconsCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var iconImage: UIImageView!
	
	private var selectedColor: UIColor = .systemBlue
	private var deselectedColor: UIColor = .systemGray5
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	public func selectCell() {
		contentView.backgroundColor = selectedColor
	}
	
	public func deselectCell() {
		contentView.backgroundColor = deselectedColor
	}
	
}
