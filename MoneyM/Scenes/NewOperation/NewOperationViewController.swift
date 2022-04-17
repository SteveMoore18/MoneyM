//
//  NewOperationViewController.swift
//  MoneyM
//
//  Created by Савелий Никулин on 18.01.2022.
//

import UIKit

protocol NewOperationDelegate {
	func operationCreated()
}

protocol NewOperationDisplay {
	func displayResult(viewModel: NewOperationModel.CreateOperation.ViewModel)
}

class NewOperationViewController: UIViewController {

	public var account: AccountEntity?
	
	public var delegate: NewOperationDelegate?
	
	public var categoryModel: CategoryModel?
	
	// MARK: - Outlets
	@IBOutlet weak var amountTextField: UITextField!
	
	@IBOutlet weak var expenseButton: UIButton!
	
	@IBOutlet weak var incomeButton: UIButton!
	
	@IBOutlet weak var categoryButton: UIButton!
	
	@IBOutlet weak var noteTextField: UITextField!
	
	@IBOutlet weak var datePicker: UIDatePicker!
	
	@IBOutlet weak var createButton: UIButton!
	
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var additionalLabel: UILabel!
    
    @IBOutlet weak var btnCreate: UIButton!
    
    // MARK: - Private variables
	private var isCreateButtonEnabled = false
	
	private(set) var operationMode = NewOperationModel.OperationMode.Expense
	
	private let mainBackgroundColor = UIColor(named: "Main Background Color")
	
	private var selectedCategory: CategoryModel.Model!
	
	private(set) var interactor: NewOperationBusinessLogic?
	private var router: NewOperationNavigate?
	
    private var constants: Constants!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		// CleanSwift setup
		setup()
		
		otherInit()
    }
    
	// MARK: - Actions
	@IBAction func closeButtonClicked(_ sender: Any) {
		dismiss(animated: true)
	}
	
	@IBAction func expenseButtonClicked(_ sender: Any) {
		operationMode = .Expense
		
		selectExpenseButton()
		deselectIncomeButton()
		
	}
	
	@IBAction func incomeButtonClicked(_ sender: Any) {
		operationMode = .Income
		
		selectIncomeButton()
		deselectExpenseButton()
	}
	
	@IBAction func categoryButtonClicked(_ sender: Any) {
		router?.navigateToCategory(mode: operationMode)
	}
	
	@IBAction func createButtonClicked(_ sender: Any) {
		guard let account = account else {
			return
		}
		
		let amount = Int(amountTextField.text!) ?? 0
		let note = noteTextField.text!
		let dateOfCreation = datePicker.date
		
		let request = NewOperationModel.CreateOperation.Request(account: account,
																amount: amount,
																mode: operationMode,
																categoryID: selectedCategory.id,
																note: note,
																dateOfCreation: dateOfCreation)
		
		interactor?.createOperation(request: request)
	}
	
	
	@IBAction func amountTextFieldEditingChanged(_ sender: Any) {
		let isEmpty = !(amountTextField.text ?? "").isEmpty
		createButtonEnable(value: isEmpty)
	}
	
	// MARK: - Private functions
	private func setup() {
		let viewController = self
		let newOperationInteractor = NewOperationInteractor()
		let newOperationPresenter = NewOperationPresenter()
		let newOperationRouter = NewOperationRouter()
		
		newOperationInteractor.presenter = newOperationPresenter
		newOperationPresenter.viewController = viewController
		newOperationRouter.viewController = viewController
		
		interactor = newOperationInteractor
		router = newOperationRouter
	}
	
	private func otherInit() {
		if categoryModel == nil {
			categoryModel = CategoryModel()
		}
		selectedCategory = categoryModel?.categoryUncategorized
		
        constants = Constants()
        amountTextField.font = constants.roundedFont(24)
        noteTextField.font = constants.roundedFont(24)
        
        localizeText()
	}
	
	private func createButtonEnable(value: Bool) {
		isCreateButtonEnabled = value
		createButton.backgroundColor = value ? .systemBlue : .systemGray3
	}
	
	private func selectExpenseButton() {
		expenseButton.backgroundColor = .systemBlue
		expenseButton.tintColor = .white
	}
	
	private func deselectExpenseButton() {
        expenseButton.backgroundColor = .systemGray5
		expenseButton.tintColor = .systemBlue
	}
	
	private func selectIncomeButton() {
		incomeButton.backgroundColor = .systemBlue
		incomeButton.tintColor = .white
	}
	
	private func deselectIncomeButton() {
		incomeButton.backgroundColor = .systemGray5
		incomeButton.tintColor = .systemBlue
	}
	
    private func localizeText()
    {
        navigationBar.topItem?.title = NSLocalizedString("new_operation", comment: "")
        amountTextField.placeholder = NSLocalizedString("amount", comment: "")
        
        expenseButton.setTitle(NSLocalizedString("expense", comment: ""), for: .normal)
        incomeButton.setTitle(NSLocalizedString("income", comment: ""), for: .normal)
        categoryButton.setTitle(NSLocalizedString("category", comment: ""), for: .normal)
        btnCreate.setTitle(NSLocalizedString("create", comment: ""), for: .normal)
        
        additionalLabel.text = NSLocalizedString("additional", comment: "")
        noteTextField.placeholder = NSLocalizedString("note", comment: "")
    }
}

// MARK: - NewOperation Display
extension NewOperationViewController: NewOperationDisplay {
	func displayResult(viewModel: NewOperationModel.CreateOperation.ViewModel) {
		
		if viewModel.success {
			delegate?.operationCreated()
			dismiss(animated: true)
		}
		
	}
}

// MARK: - Category delegate
extension NewOperationViewController: CategoryDelegate {
	
	func categorySelected(category: CategoryModel.Model) {
		categoryButton.setTitle("\(category.emojiIcon) \(category.title)", for: .normal)
		selectedCategory = category
	}
	
}
