//
//  OperationsViewController.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import UIKit

protocol DisplayOperations {
	func displayOperation(viewModel: OperationsModel.Operations.ViewModel)
}

class OperationsViewController: UIViewController {

	// MARK: - Outlets
	@IBOutlet weak var balanceTitleLabel: UILabel!
	
	@IBOutlet weak var balanceValueLabel: UILabel!
	
	@IBOutlet weak var expenseTitleLabel: UILabel!
	
	@IBOutlet weak var expenseValueLabel: UILabel!
	
	@IBOutlet weak var incomeTitleLabel: UILabel!
	
	@IBOutlet weak var incomeValueLabel: UILabel!
	
	@IBOutlet weak var operationsTableView: UITableView!
	
	@IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var statusStackViewHeightConstraint: NSLayoutConstraint!
	
	var interactor: OperationsBusinessLogic?
	var router: OperationNavigate?
	
	public var account: AccountEntity?
	
	// MARK: - Private variables
	private var viewModel: OperationsModel.Operations.ViewModel?
	
	private let bottomMargin: CGFloat = 16
	
	private(set) var categoryModel: CategoryModel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		// CleanSwift setup
		setup()
		
		otherInit()
    }
    
	// MARK: - Private functions
	private func setup() {
		let viewController = self
		let operationsInteractor = OperationsInteractor()
		let operationsPresenter = OperationsPresenter()
		let operationRouter = OperationsRouter()
		
		operationsInteractor.presenter = operationsPresenter
		operationsPresenter.viewController = viewController
		operationRouter.viewController = viewController
		
		interactor = operationsInteractor
		router = operationRouter
	}
	
	private func otherInit() {
		
		categoryModel = CategoryModel()
		
		operationsTableView.delegate = self
		operationsTableView.dataSource = self
		
		fetchOperations()
		
	}
	
	private func fetchOperations() {
		if let account = account {
			let request = OperationsModel.Operations.Request(account: account)
			interactor?.requestOperations(request: request)
		}
	}
	
	// MARK: - Actions
	@IBAction func newOperationButtonClicked(_ sender: Any) {
		router?.navigateToNewOperation()
	}
	
}

// MARK: - TableView delegate
extension OperationsViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel?.operations.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = operationsTableView.dequeueReusableCell(withIdentifier: "cell") as! UIOperationTableViewCell
		
		let operation = viewModel?.operations[indexPath.row]
		
		let categoryID = Int((operation?.operation.categoryID)!)
		let category = categoryModel.categoryBy(id: categoryID) ?? categoryModel.categoryUncategorized

		cell.categoryLabel.text = category?.title
		cell.iconLabel.text = category?.emojiIcon
		cell.amountLabel.text = operation?.amountValue
		cell.amountLabel.textColor = operation?.amountColor
		cell.noteLabel.text = operation?.operation.note
		
		let tableViewContentHeight = operationsTableView.contentSize.height
		scrollViewHeightConstraint.constant = tableViewContentHeight + statusStackViewHeightConstraint.constant + bottomMargin
		
		return cell
	}
	
	
}

// MARK: - Display Operations
extension OperationsViewController: DisplayOperations {
	func displayOperation(viewModel: OperationsModel.Operations.ViewModel) {
		
		DispatchQueue.main.async {
			self.viewModel = viewModel
			self.operationsTableView.reloadData()
		}
		
	}
	
}

// MARK: - NewOperation Delegate
extension OperationsViewController: NewOperationDelegate {
	
	func operationCreated() {
		fetchOperations()
		operationsTableView.reloadData()
	}
	
}
