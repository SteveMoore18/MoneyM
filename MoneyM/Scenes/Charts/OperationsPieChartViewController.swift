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
    func displayPieChart(viewModel: OperationsPieChartModel.PieChart.ViewModel)
}

class OperationsPieChartViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var operationsTableView: UITableView!
    
    private var interactor: OperationsPieChartInteractor?
    
    private var operationsTableViewData: [OperationsPieChartModel.OperationPresentModel] = []
    
//    var operationsArray: [OperationEntity]?
//    var currency: CurrencyModel.Model?
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
            interactor?.groupOperations(request: OperationsPieChartModel.Operations.Request(operationsArray: data.operationsArray))
            interactor?.requestPieChartData(request: OperationsPieChartModel.PieChart.Request(operations: operationsTableViewData))
        }
        
        pieChartView.holeColor = NSUIColor(named: "Main Background Color")
        pieChartView.holeRadiusPercent = 0.5
        pieChartView.data?.setValueTextColor(.label)
        pieChartView.legend.enabled = false

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.multiplier = 1
        formatter.currencySymbol = data?.currency.symbol
        
        pieChartView.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UIOperationTableViewCell
        
        let operation = operationsTableViewData[indexPath.row]
        
        cell.iconLabel.text = operation.categoryIcon
        cell.categoryLabel.text = operation.categoryTitle
        cell.amountLabel.text = operation.amount + " " + (data?.currency.symbol ?? "$")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
}

// MARK: - Display OpeationsPieChart
extension OperationsPieChartViewController: DisplayOperationsPieChart
{
    func displayPieChart(viewModel: OperationsPieChartModel.PieChart.ViewModel) {
        pieChartView.data = viewModel.pieChartData
    }
    
    func displayOperations(viewModel: OperationsPieChartModel.Operations.ViewModel) {
        operationsTableViewData = viewModel.operations
    }
    
}
