//
//  UICategoryTableViewCell.swift
//  MoneyM
//
//  Created by Савелий Никулин on 19.01.2022.
//

import UIKit

class UICategoryTableViewCell: UITableViewCell {
	
	@IBOutlet weak var iconLabel: UILabel!
	
	@IBOutlet weak var titleLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
