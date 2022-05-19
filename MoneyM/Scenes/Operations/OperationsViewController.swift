//
//  OperationsViewController.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import UIKit
import CoreGraphics

protocol DisplayOperations {
	func displayOperation(viewModel: OperationsModel.Operations.ViewModel)
	func displayStatistics(viewModel: OperationsModel.Statistics.ViewModel)
    func deletedOperation(viewModel: OperationsModel.DeleteOperation.ViewModel)
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
	
    @IBOutlet weak var newOperationButton: UIButton!
    
    @IBOutlet weak var expenseView: UIView!
    
    @IBOutlet weak var incomeView: UIView!
    
    @IBOutlet weak var balanceView: UIView!
    
    @IBOutlet weak var btnNewOperation: UIButton!
    
    var interactor: OperationsBusinessLogic?
	var router: OperationNavigate?
    var accountViewController: AccountsViewController?
	
	public var account: AccountEntity?
	
	// MARK: - Private variables
	private var viewModel: OperationsModel.Operations.ViewModel?
	
	private let bottomMargin: CGFloat = 48
	
	private(set) var categoryModel: CategoryModel!
    
    private var constants: Constants!
    
    private var currency: CurrencyModel.Model!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		// CleanSwift setup
		setup()
		
		otherInit()
		updateStatistics()
    }
    
	// MARK: - Private functions
	private func setup() {
        guard let account = account else {
            return
        }
		let viewController = self
		let operationsInteractor = OperationsInteractor(account: account)
		let operationsPresenter = OperationsPresenter()
		let operationRouter = OperationsRouter()
		
		operationsInteractor.presenter = operationsPresenter
		operationsPresenter.viewController = viewController
		operationRouter.viewController = viewController
		
		interactor = operationsInteractor
		router = operationRouter
	}
	
	private func otherInit() {
        constants = Constants()
		
		categoryModel = CategoryModel()
		
		operationsTableView.delegate = self
		operationsTableView.dataSource = self
		
		fetchOperations()
		
        balanceValueLabel.font = constants.roundedFont(28)
        expenseValueLabel.font = constants.roundedFont(24)
        incomeValueLabel.font = constants.roundedFont(24)
        
        newOperationButton.titleLabel?.font = constants.roundedFont(20)
        
        dropShadowOf(view: expenseView)
        dropShadowOf(view: incomeView)
        dropShadowOf(view: balanceView)
        
        currency = getCurrency()
        
        balanceValueLabel.text = "0 $"
        incomeValueLabel.text = "0 $"
        expenseValueLabel.text = "0 $"
        
        newOperationButton.isEnabled = account != nil
        
        localizeText()
	}
    
    private func getCurrency() -> CurrencyModel.Model?
    {
        guard let account = account else {
            return nil
        }
        let currencyModel = CurrencyModel()
        let result = currencyModel.currencyBy(id: Int(account.currencyID))
        return result
    }
    
    private func dropShadowOf(view: UIView)
    {
        view.layer.masksToBounds = false
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 9
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
	
	private func fetchOperations() {
		if let account = account {
			let request = OperationsModel.Operations.Request(account: account)
			interactor?.requestOperations(request: request)
		}
	}
	
	private func updateStatistics()
	{
		if let account = account {
			let request = OperationsModel.Statistics.Request(account: account)
			interactor?.requestStatistics(request: request)
		}
	}
    
    private func updateScrollViewHeight()
    {
        let sectionsHeight = CGFloat(32 * (viewModel?.operations.count)!)
        let tableViewContentHeight = operationsTableView.contentSize.height + sectionsHeight
        let height = tableViewContentHeight + statusStackViewHeightConstraint.constant + bottomMargin
        let viewHeight = view.frame.height - statusStackViewHeightConstraint.constant
        scrollViewHeightConstraint.constant = (scrollViewHeightConstraint.constant < viewHeight) ? view.frame.height - 80 : height
    }
    
    private func localizeText()
    {
        title = NSLocalizedString("operations", comment: "")
        balanceTitleLabel.text = NSLocalizedString("balance", comment: "")
        incomeTitleLabel.text = NSLocalizedString("income", comment: "")
        expenseTitleLabel.text = NSLocalizedString("expense", comment: "")
        btnNewOperation.setTitle(NSLocalizedString("new_operation", comment: ""), for: .normal)
    }
	
	// MARK: - Actions
	@IBAction func newOperationButtonClicked(_ sender: Any) {
		router?.navigateToNewOperation()
	}
	
}

// MARK: - TableView delegate
extension OperationsViewController: UITableViewDelegate, UITableViewDataSource {
	
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.dates.count ?? 0
    }
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.operations[section].count ?? 0
	}
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIOperationsTableViewHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 28))
        
        view.dateLabel.text = viewModel?.dates[section]
        
        return view
    }
    
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = operationsTableView.dequeueReusableCell(withIdentifier: "cell") as! UIOperationTableViewCell
		
        let operation = viewModel?.operations[indexPath.section][indexPath.row]
        
		let categoryID = Int((operation?.operation.categoryID)!)
		let category = categoryModel.categoryBy(id: categoryID) ?? categoryModel.categoryUncategorized

		cell.categoryLabel.text = category?.title
		cell.iconLabel.text = category?.emojiIcon
        cell.amountLabel.text = (operation?.amountValue ?? "0") + " " + currency.symbol
		cell.amountLabel.textColor = operation?.amountColor
		cell.noteLabel.text = operation?.operation.note
        cell.amountLabel.font = constants.roundedFont(20)
		
		updateScrollViewHeight()
        
		return cell
	}
	
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: NSLocalizedString("delete", comment: ""))
        { (action, view, complitionHandler) in
            if self.account != nil
            {
                
                let request = OperationsModel.DeleteOperation.Request(indexPath: indexPath)
                self.interactor?.deleteOperation(request: request)
                
                self.updateStatistics()
            }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
	
}

// MARK: - Display Operations
extension OperationsViewController: DisplayOperations {
    
    func deletedOperation(viewModel: OperationsModel.DeleteOperation.ViewModel) {
        let indexPath = viewModel.indexPath
        
        self.viewModel?.operations[indexPath.section].remove(at: indexPath.row)
        self.operationsTableView.deleteRows(at: [indexPath], with: .top)

        if self.viewModel!.operations[indexPath.section].isEmpty
        {
            self.viewModel?.operations.remove(at: indexPath.section)
            self.viewModel?.dates.remove(at: indexPath.section)
            self.operationsTableView.deleteSections(IndexSet(arrayLiteral: indexPath.section), with: .middle)
        }
        
        self.operationsTableView.beginUpdates()
        self.operationsTableView.reloadData()
        self.operationsTableView.endUpdates()
    }
    
	func displayStatistics(viewModel: OperationsModel.Statistics.ViewModel) {
		
        balanceValueLabel.text = viewModel.balance + " " + currency.symbol
		balanceValueLabel.textColor = viewModel.balanceColor
		expenseValueLabel.text = viewModel.expense + " " + currency.symbol
		incomeValueLabel.text = viewModel.income + " " + currency.symbol
		
	}
	
	func displayOperation(viewModel: OperationsModel.Operations.ViewModel) {
		
        self.viewModel?.operations.removeAll()
        self.viewModel = viewModel
        self.operationsTableView.reloadData()
        
	}
	
}

// MARK: - NewOperation Delegate
extension OperationsViewController: NewOperationDelegate {
	
	func operationCreated() {
		fetchOperations()
		operationsTableView.reloadData()
        updateStatistics()
        accountViewController?.updateAccountsBalance()
	}
	
}
