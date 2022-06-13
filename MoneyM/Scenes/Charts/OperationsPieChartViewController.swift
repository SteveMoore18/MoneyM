//
//  OperationsPieChartViewController.swift
//  MoneyM
//
//  Created by Савелий Никулин on 23.05.2022.
//

import UIKit
import Charts

protocol DisplayOperationsPieChart
{
    func displayOperations(viewModel: OperationsPieChartModel.Operations.ViewModel)
}

class OperationsPieChartViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var operationsTableView: UITableView!
    
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    private var interactor: OperationsPieChartInteractor?
    
    private var operationsTableViewData: [OperationsPieChartModel.OperationPresentModel] = []
    
    public var data: OperationsPieChartModel.Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // CleanSwift setup
        setup()
        
        otherInit()
        
    }

    // MARK: - Private functions
    private func setup()
    {
        let viewController = self
        let operationsPieChartInteractor = OperationsPieChartInteractor()
        let operationsPieChartPresenter = OperationsPieChartPresenter()
        
        operationsPieChartInteractor.presenter = operationsPieChartPresenter
        operationsPieChartPresenter.viewController = viewController
        
        interactor = operationsPieChartInteractor
    }
    
    private func otherInit()
    {
        
        operationsTableView.delegate = self
        operationsTableView.dataSource = self
        
        if let data = data {
            interactor?.requestData(request: OperationsPieChartModel.Operations.Request(operationsArray: data.operationsArray))
        }
        
        pieChartView.holeColor = NSUIColor(named: "Main Background Color")
        pieChartView.holeRadiusPercent = 0.5
        pieChartView.data?.setValueTextColor(.label)
        pieChartView.legend.enabled = false
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.sliceTextDrawingThreshold = 20
        pieChartView.rotationEnabled = false

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.multiplier = 1
        formatter.currencySymbol = data?.currency.symbol
        
        pieChartView.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        scrollViewHeightConstraint.constant = view.frame.height
        
        navigationBar.topItem?.title = NSLocalizedString("chart_title", comment: "")
    }
    
    // MARK: - Actions
    @IBAction func btnCloseClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - TableView delegate
extension OperationsPieChartViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        operationsTableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UIOperationWithColorTableViewCell
        
        let operation = operationsTableViewData[indexPath.row]
        
        cell.iconLabel.text = operation.categoryIcon
        cell.categoryLabel.text = operation.categoryTitle
        cell.amountLabel.text = operation.amount + " " + (data?.currency.symbol ?? "$")
        cell.colorView.backgroundColor = operation.color
        
        let pieChartHeight = pieChartView.frame.height
        let tableViewHeight = operationsTableView.frame.height
        let contentHeight = operationsTableView.contentSize.height
        scrollViewHeightConstraint.constant = pieChartHeight + tableViewHeight + contentHeight
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
}

// MARK: - Display OpeationsPieChart
extension OperationsPieChartViewController: DisplayOperationsPieChart
{
    
    func displayOperations(viewModel: OperationsPieChartModel.Operations.ViewModel) {
        operationsTableViewData = viewModel.operations
        pieChartView.data = viewModel.pieChartData
    }
    
}
