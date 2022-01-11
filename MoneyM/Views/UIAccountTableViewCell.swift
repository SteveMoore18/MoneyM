//
//  UIAccountTableViewCell.swift
//  MoneyM
//
//  Created by Савелий Никулин on 10.01.2022.
//

import UIKit

class UIAccountTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	
	@IBOutlet weak var dateOfCreationLabel: UILabel!
	
	@IBOutlet weak var balanceLabel: UILabel!
	
	@IBOutlet weak var iconView: UIView!
	
	@IBOutlet weak var iconImage: UIImageView!
	
	public static var height: CGFloat?
	
    override func awakeFromNib() {
        super.awakeFromNib()
		UIAccountTableViewCell.height = frame.height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
