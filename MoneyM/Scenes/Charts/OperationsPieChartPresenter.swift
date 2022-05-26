//
//  OperationsPieChartPresenter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 23.05.2022.
//

import Foundation
import Charts

protocol OperationsPieChartPresenterLogic
{
    func presentGroupedOperations(response: OperationsPieChartModel.Operations.Response)
    func presentPieChartData(response: OperationsPieChartModel.PieChart.Response)
}

class OperationsPieChartPresenter
{
    
    var viewController: OperationsPieChartViewController?
    
}

extension OperationsPieChartPresenter: OperationsPieChartPresenterLogic
{
    func presentPieChartData(response: OperationsPieChartModel.PieChart.Response) {
        
        let pieChartData = PieChartData()
        let dataSet = PieChartDataSet(entries: response.operations)
        dataSet.colors = ChartColorTemplates.vordiplom()
        
        pieChartData.append(dataSet)
        
        let viewModel = OperationsPieChartModel.PieChart.ViewModel(pieChartData: pieChartData)
        viewController?.displayPieChart(viewModel: viewModel)
    }
    
    func presentGroupedOperations(response: OperationsPieChartModel.Operations.Response) {
        
        let categoryModel = CategoryModel()
        
        let groupedOperations: [OperationsPieChartModel.OperationPresentModel] = Dictionary(grouping: response.operationsArray) { $0.categoryID }
            .map { (key: Int64, value: [OperationEntity]) in
                var amount: Int = 0
                value.forEach { amount += Int($0.amount) }
                
                let category = categoryModel.categoryBy(id: Int(key))
                let operationPresent = OperationsPieChartModel.OperationPresentModel(categoryIcon: category!.emojiIcon,
                                                                                     categoryTitle: category!.title,
                                                                                     amount: "\(amount)")
                
                return operationPresent
            }
        
        let viewModel = OperationsPieChartModel.Operations.ViewModel(operations: groupedOperations)
        viewController?.displayOperations(viewModel: viewModel)
        
    }
        
}
