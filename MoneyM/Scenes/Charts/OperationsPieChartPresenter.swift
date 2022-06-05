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
        dataSet.colors = ChartColorTemplates.material()
        
        dataSet.valueLinePart1OffsetPercentage = 0.3
        dataSet.valueLinePart1Length = 0.3
        dataSet.valueLinePart2Length = 0.3
        dataSet.yValuePosition = .outsideSlice
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueFont = .systemFont(ofSize: 16)
        dataSet.highlightEnabled = false
        
        pieChartData.append(dataSet)
        
        let viewModel = OperationsPieChartModel.PieChart.ViewModel(pieChartData: pieChartData)
        viewController?.displayPieChart(viewModel: viewModel)
    }
    
    func presentGroupedOperations(response: OperationsPieChartModel.Operations.Response) {
        
        let categoryModel = CategoryModel()
        
        var groupedOperations: [OperationsPieChartModel.OperationPresentModel] = Dictionary(grouping: response.operationsArray) { $0.categoryID }
            .map { (key: Int64, value: [OperationEntity]) in
                var amount: Int = 0
                value.forEach { amount += Int($0.amount) }
                
                let category = categoryModel.categoryBy(id: Int(key))
                let operationPresent = OperationsPieChartModel.OperationPresentModel(categoryIcon: category!.emojiIcon,
                                                                                     categoryTitle: category!.title,
                                                                                     amount: "\(amount)")
                
                return operationPresent
            }
        groupedOperations = groupedOperations.sorted { Int($0.amount) ?? 0 > Int($1.amount) ?? 0 }
        let viewModel = OperationsPieChartModel.Operations.ViewModel(operations: groupedOperations)
        viewController?.displayOperations(viewModel: viewModel)
        
    }
        
}
