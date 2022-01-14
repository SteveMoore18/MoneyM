//
//  NewAccountViewController.swift
//  MoneyM
//
//  Created by Савелий Никулин on 11.01.2022.
//

import UIKit
import Foundation

protocol NewAccountDisplayData {
	func displayColors(viewModel: NewAccountModel.Colors.ViewModel)
	func displayIcons(viewModel: NewAccountModel.Icons.ViewModel)
	
}

class NewAccountViewController: UIViewController {

	// MARK: - Outlets
	@IBOutlet weak var iconBackgroundView: UIView!
	
	@IBOutlet weak var iconImage: UIImageView!
	
	@IBOutlet weak var titleTextField: UITextField!
	
	@IBOutlet weak var balanceTextField: UITextField!
	
	@IBOutlet weak var currencyButton: UIButton!
	
	@IBOutlet weak var colorsCollectionView: UICollectionView!
	
	@IBOutlet weak var iconsCollectionView: UICollectionView!
	
	@IBOutlet weak var iconsCollectionViewConstraintHeight: NSLayoutConstraint!
	
	// MARK: - Other variables
	var interactor: NewAccountBusinesslogic?
	
	private var colorsViewModel: NewAccountModel.Colors.ViewModel?
	private var iconsViewModel: NewAccountModel.Icons.ViewModel?
	
	private var constants = Constants()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		// CleanSwift setup
		setup()
        
		otherInit()
    }
	
	// MARK: - Private functions
	private func setup() {
		let viewController = self
		let newAccountInteractor = NewAccountInteractor()
		let newAccountPresenter = NewAccountPresenter()
		
		newAccountInteractor.presenter = newAccountPresenter
		newAccountPresenter.viewControlller = viewController
		
		interactor = newAccountInteractor
		
	}
	
	private func otherInit() {
		
		interactor?.requestColors()
		interactor?.requestIcons()
		
		initCollectionViews()
		
		settingFonts()
		
		dropShadow(iconBackgroundView)
		
	}
	
	private func initCollectionViews() {
		colorsCollectionView.delegate = self
		colorsCollectionView.dataSource = self
		
		iconsCollectionView.delegate = self
		iconsCollectionView.dataSource = self
	}
	
	private func settingFonts() {
		titleTextField.font = constants.roundedFont(24)
		balanceTextField.font = constants.roundedFont(24)
	}
	
	private func dropShadow(_ view: UIView) {
		view.layer.masksToBounds = false
		view.layer.shadowColor = iconBackgroundView.backgroundColor?.cgColor
		view.layer.shadowOpacity = 0.4
		view.layer.shadowOffset = .zero
		view.layer.shadowRadius = 15
	}
	
	private func selectIcon(_ indexPath: IndexPath) {
		if let cell = iconsCollectionView.cellForItem(at: indexPath) as? UIIconsCollectionViewCell {
			deselectIcon(IndexPath(row: 0, section: 0))
			cell.selectCell()
			iconImage.image = cell.iconImage.image
		}
	}
	
	private func deselectIcon(_ indexPath: IndexPath) {
		if let cell = iconsCollectionView.cellForItem(at: indexPath) as? UIIconsCollectionViewCell {
			cell.deselectCell()
		}
	}
	
	private func selectColor(_ indexPath: IndexPath) {
		if let cell = colorsCollectionView.cellForItem(at: indexPath) as? UIColorCollectionViewCell {
			deselectColor(IndexPath(row: 0, section: 0))
			iconBackgroundView.backgroundColor = cell.contentView.backgroundColor
			dropShadow(iconBackgroundView)
			cell.selectCell()
		}
	}
	
	private func deselectColor(_ indexPath: IndexPath) {
		if let cell = colorsCollectionView.cellForItem(at: indexPath) as? UIColorCollectionViewCell {
			cell.deselectCell()
		}
	}

	// MARK: - Actions
	@IBAction func closeButtonClicked(_ sender: Any) {
		dismiss(animated: true)
	}
	
	@IBAction func createButtonClicked(_ sender: Any) {
		
	}
	
}

// MARK: - NewAccount Collection view delegate
extension NewAccountViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		var number: Int?
		
		if collectionView == colorsCollectionView {
			number = colorsViewModel?.colors.count
		} else if collectionView == iconsCollectionView {
			number = iconsViewModel?.icons.count
		}
		
		return number ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if collectionView == colorsCollectionView {
			let cell = colorsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UIColorCollectionViewCell
			let color = colorsViewModel?.colors[indexPath.row]
			
			cell.contentView.backgroundColor = color
			cell.selectedColorView.backgroundColor = color
			
			selectColor(IndexPath(row: 0, section: 0))
			
			return cell
			
		} else if collectionView == iconsCollectionView {
			let cell = iconsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UIIconsCollectionViewCell
			let image = iconsViewModel?.icons[indexPath.row]
			
			cell.iconImage.image = image
			iconsCollectionViewConstraintHeight.constant = iconsCollectionView.contentSize.height + 40
			
			selectIcon(IndexPath(row: 0, section: 0))
			
			return cell
		}
		
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if collectionView == colorsCollectionView {
			selectColor(indexPath)
		} else if collectionView == iconsCollectionView {
			selectIcon(indexPath)
		}
		
	}
	
	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		
		if collectionView == colorsCollectionView {
			deselectColor(indexPath)
		} else if collectionView == iconsCollectionView {
			deselectIcon(indexPath)
		}
		
	}
	
}

// MARK: - NewAccount Display data
extension NewAccountViewController: NewAccountDisplayData {
	
	func displayColors(viewModel: NewAccountModel.Colors.ViewModel) {
		self.colorsViewModel = viewModel
	}
	
	func displayIcons(viewModel: NewAccountModel.Icons.ViewModel) {
		self.iconsViewModel = viewModel
	}
	
}
