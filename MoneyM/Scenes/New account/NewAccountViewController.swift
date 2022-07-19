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

protocol NewAccountDelegate {
	func accountDidCreate()
}

class NewAccountViewController: UIViewController {

	// MARK: - Outlets
	@IBOutlet weak var iconBackgroundView: UIView!
	@IBOutlet weak var iconBackgroundViewForAnimation: UIView!
	
	@IBOutlet weak var iconImage: UIImageView!
	
	@IBOutlet weak var titleTextField: UITextField!
	
	@IBOutlet weak var balanceTextField: UITextField!
	
	@IBOutlet weak var currencyButton: UIButton!
	
	@IBOutlet weak var colorsCollectionView: UICollectionView!
	
	@IBOutlet weak var iconsCollectionView: UICollectionView!
	
	@IBOutlet weak var iconsCollectionViewConstraintHeight: NSLayoutConstraint!
	
    @IBOutlet weak var btnCreate: UIButton!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    // MARK: - Other variables
	private var interactor: NewAccountBusinesslogic?
	var router: NewAccountNavigate?
	
	private var colorsViewModel: NewAccountModel.Colors.ViewModel?
	private var iconsViewModel: NewAccountModel.Icons.ViewModel?
    
	internal var selectedColorIndex: IndexPath?
	internal var selectedIconIndex: IndexPath?
    internal var selectedCurrencyID = 0
	internal var currencyButtonTitle: String?
	
	private var constants = Constants()
	
	public var newAccountDelegate: NewAccountDelegate?
	
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
		let newAccountRouter = NewAccountRouter()
		
		newAccountInteractor.presenter = newAccountPresenter
		newAccountPresenter.viewControlller = viewController
		newAccountRouter.viewController = viewController
		
		interactor = newAccountInteractor
		router = newAccountRouter
	}
	
	internal func otherInit() {
		
		interactor?.requestColors()
		interactor?.requestIcons()
		
		initCollectionViews()
		settingCollectionView()
		
		settingFonts()
		
		dropShadow(iconBackgroundView)
		
        currencyButton.titleLabel?.font = constants.roundedFont(20)
		
        navigationBar.shadowImage = UIImage()
		
		titleTextField.delegate = self
		titleTextField.returnKeyType = .next
		
		balanceTextField.delegate = self
		
		balanceTextField.inputAccessoryView = addDoneBackToKeyboard()
		
		titleTextField.becomeFirstResponder()
        
        localizeText()
	}
	
	private func addDoneBackToKeyboard() -> UIToolbar
	{
		let toolBar = UIToolbar()
		toolBar.sizeToFit()
		
		let btnDone = UIBarButtonItem(barButtonSystemItem: .done,
									  target: self,
									  action: #selector(balanceTextFieldDoneButtonClicked(_:)))
		
		let btnBack = UIBarButtonItem(title: NSLocalizedString("back", comment: ""),
									  style: .plain,
									  target: self,
									  action: #selector(balanceTextFieldBackButtonClicked(_:)))
		
		let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		
		toolBar.items = [btnBack, flexibleSpace, btnDone]
		
		return toolBar
	}
	
	private func initCollectionViews() {
		colorsCollectionView.delegate = self
		colorsCollectionView.dataSource = self
		
		iconsCollectionView.delegate = self
		iconsCollectionView.dataSource = self
        
        colorsCollectionView.allowsMultipleSelection = false
        iconsCollectionView.allowsMultipleSelection = false
	}
	
	private func settingCollectionView()
	{
		if selectedColorIndex == nil
		{
			selectedColorIndex = randomIndexPath(range: 0..<(colorsViewModel?.colors.count)! - 1)
		}
		
		if selectedIconIndex == nil
		{
			selectedIconIndex = randomIndexPath(range: 0..<(iconsViewModel?.icons.count)! - 1)
		}
		
		if currencyButtonTitle == nil
		{
			currencyButtonTitle = constants.defaultCurrency().all
		}
		currencyButton.setTitle(currencyButtonTitle, for: .normal)
		
		
		colorsCollectionView.performBatchUpdates {
			selectColor(selectedColorIndex!)
		}
		
		iconsCollectionView.performBatchUpdates {
			selectIcon(selectedIconIndex!)
		}
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
	
	internal func selectIcon(_ indexPath: IndexPath) {
		if let cell = iconsCollectionView.cellForItem(at: indexPath) as? UIIconsCollectionViewCell {
            iconsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
			cell.selectCell()
			iconImage.image = cell.iconImage.image
            selectedIconIndex = indexPath
		}
	}
	
	private func deselectIcon(_ indexPath: IndexPath) {
		if let cell = iconsCollectionView.cellForItem(at: indexPath) as? UIIconsCollectionViewCell {
			cell.deselectCell()
		}
	}
	
	internal func selectColor(_ indexPath: IndexPath) {
		if let cell = colorsCollectionView.cellForItem(at: indexPath) as? UIColorCollectionViewCell {
            colorsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
			
			iconBackgroundViewForAnimation.transform = CGAffineTransform(scaleX: 0, y: 0)
			iconBackgroundViewForAnimation.backgroundColor = cell.contentView.backgroundColor
			
			UIView.animate(withDuration: 0.25) {
				self.iconBackgroundViewForAnimation.transform = CGAffineTransform(scaleX: 1, y: 1)
			} completion: { _ in
				self.iconBackgroundView.backgroundColor = cell.contentView.backgroundColor
				self.dropShadow(self.iconBackgroundView)
			}
			
			cell.selectCell()
            selectedColorIndex = indexPath
		}
	}
	
	private func deselectColor(_ indexPath: IndexPath) {
		if let cell = colorsCollectionView.cellForItem(at: indexPath) as? UIColorCollectionViewCell {
			cell.deselectCell()
		}
	}
    
    private func randomIndexPath(range: Range<Int>) -> IndexPath
    {
        let r = Int.random(in: range)
        return IndexPath(row: r, section: 0)
    }
    
    internal func localizeText()
    {
        navigationBar.topItem?.title = NSLocalizedString("new_account", comment: "")
        titleTextField.placeholder = NSLocalizedString("title", comment: "")
        balanceTextField.placeholder = NSLocalizedString("balance", comment: "")
        btnCreate.setTitle(NSLocalizedString("create", comment: ""), for: .normal)
    }

	// MARK: - Actions
	@IBAction func closeButtonClicked(_ sender: Any) {
		dismiss(animated: true)
	}
	
	@IBAction func createButtonClicked(_ sender: Any) {
		let title = titleTextField.text!
		let balance = Int(balanceTextField.text!) ?? 0
        let iconID = selectedIconIndex?.row ?? 0
        let colorID = selectedColorIndex?.row ?? 0
		
		let request = NewAccountModel.CreateAccount.Request(title: title,
															balance: balance,
															iconID: iconID,
                                                            colorID: colorID,
                                                            currencyID: selectedCurrencyID)
		
		interactor?.createAccount(request: request)
		newAccountDelegate?.accountDidCreate()
        
		dismiss(animated: true)
	}
	
	@IBAction func currencyButtonClicked(_ sender: Any) {
		router?.navigateToCurrency()
	}
	
	@objc private func balanceTextFieldDoneButtonClicked(_ sender: Any)
	{
		balanceTextField.endEditing(true)
	}
	
	@objc private func balanceTextFieldBackButtonClicked(_ sender: Any)
	{
		balanceTextField.endEditing(true)
		titleTextField.becomeFirstResponder()
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
            
			return cell
			
		} else if collectionView == iconsCollectionView {
			let cell = iconsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UIIconsCollectionViewCell
			let image = iconsViewModel?.icons[indexPath.row]
			
			cell.iconImage.image = image
			
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

// MARK: - Currency delegate
extension NewAccountViewController: CurrencyDelegate {
	
	func currencySelected(currency: CurrencyModel.Model) {
		currencyButton.setTitle(currency.all, for: .normal)
        selectedCurrencyID = currency.id
	}
	
}

// MARK: - TextField delegate
extension NewAccountViewController: UITextFieldDelegate
{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		if textField == titleTextField
		{
			balanceTextField.becomeFirstResponder()
		}
		
		return true
	}
}
