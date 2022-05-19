//
//  UIOperationsTableViewHeader.swift
//  MoneyM
//
//  Created by Савелий Никулин on 19.05.2022.
//

import UIKit

class UIOperationsTableViewHeader: UIView {

    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureDateLabel(frame: frame)
        
        addSubview(dateLabel)
    }
    
    private func configureDateLabel(frame: CGRect)
    {
        dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .systemGray
        
        dateLabel.frame = CGRect(x: 16, y: 0, width: frame.width, height: frame.height)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
