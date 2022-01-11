//
//  NewAccountViewController.swift
//  MoneyM
//
//  Created by Савелий Никулин on 11.01.2022.
//

import UIKit

class NewAccountViewController: UIViewController {

	// MARK: - Outlets
	@IBOutlet weak var iconBackgroundView: UIView!
	
	@IBOutlet weak var iconImage: UIImageView!
	
	@IBOutlet weak var titleTextField: UITextField!
	
	@IBOutlet weak var balanceTextField: UITextField!
	
	@IBOutlet weak var currencyButton: UIButton!
	
	@IBOutlet weak var colorsCollectionView: UICollectionView!
	
	@IBOutlet weak var iconsCollectionView: UICollectionView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

	// MARK: - Actions
	
	@IBAction func closeButtonClicked(_ sender: Any) {
		dismiss(animated: true)
	}
	
	@IBAction func createButtonClicked(_ sender: Any) {
	}
	
}
