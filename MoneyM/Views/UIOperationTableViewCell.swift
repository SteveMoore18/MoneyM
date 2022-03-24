//
//  UIOperationTableViewCell.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import UIKit

class UIOperationTableViewCell: UITableViewCell {

	@IBOutlet weak var iconBackgrundView: UIView!
	
	@IBOutlet weak var iconLabel: UILabel!
	
	@IBOutlet weak var categoryLabel: UILabel!
	
	@IBOutlet weak var noteLabel: UILabel!
	
	@IBOutlet weak var amountLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView?.backgroundColor = UIColor(named: "Table View Cell Background")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
