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
    
    var operationsArray: [OperationEntity]?
    
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
        
        if let operationsArray = operationsArray {
            interactor?.groupOperations(request: OperationsPieChartModel.Operations.Request(operationsArray: operationsArray))
            interactor?.requestPieChartData(request: OperationsPieChartModel.PieChart.Request(operations: operationsTableViewData))
        }
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let operation = operationsTableViewData[indexPath.row]
        
        cell.textLabel?.text = operation.categoryIcon + operation.categoryTitle + operation.amount
        
        return cell
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
