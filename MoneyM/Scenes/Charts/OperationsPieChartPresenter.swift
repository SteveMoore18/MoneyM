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
    func presentData(response: OperationsPieChartModel.Operations.Response)
}

class OperationsPieChartPresenter
{
    
    var viewController: OperationsPieChartViewController?
    
    private func groupOperation(operations: [OperationEntity]) -> [OperationsPieChartModel.OperationPresentModel]
    {
        let categoryModel = CategoryModel()
        return Dictionary(grouping: operations) { $0.categoryID }
            .map { (key: Int64, value: [OperationEntity]) in
                var amount: Int = 0
                value.forEach { amount += Int($0.amount) }
                
                let category = categoryModel.categoryBy(id: Int(key)) ?? categoryModel.categoryUncategorized!
                let operationPresent = OperationsPieChartModel.OperationPresentModel(categoryIcon: category.emojiIcon, categoryTitle: category.title, amount: "\(amount)", color: .blue)
                
                return operationPresent
            }
    }
    
    private func createDataSet(entries: [PieChartDataEntry]) -> PieChartDataSet
    {
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = ChartColorTemplates.material()

        dataSet.valueLinePart1OffsetPercentage = 0.3
        dataSet.valueLinePart1Length = 0.3
        dataSet.valueLinePart2Length = 0.3
        dataSet.yValuePosition = .insideSlice
        dataSet.xValuePosition = .insideSlice
        dataSet.valueFont = .systemFont(ofSize: 16)
        dataSet.highlightEnabled = false
        
        return dataSet
    }
    
}

extension OperationsPieChartPresenter: OperationsPieChartPresenterLogic
{
    
    func presentData(response: OperationsPieChartModel.Operations.Response) {
        
        var groupedOperations = groupOperation(operations: response.operationsArray)
        
        let pieChartDataEntityArray = groupedOperations.map { operation -> PieChartDataEntry in
            let label = operation.categoryIcon + " " + operation.categoryTitle
            return PieChartDataEntry(value: Double(operation.amount) ?? 0, label: label)
        }
        
        let pieChartData = PieChartData()
        let dataSet = createDataSet(entries: pieChartDataEntityArray)

        pieChartData.append(dataSet)

        for i in 0..<dataSet.entries.count
        {
            let color = dataSet.color(atIndex: i)
            groupedOperations[i].color = color
        }
        
        groupedOperations = groupedOperations.sorted { Int($0.amount) ?? 0 > Int($1.amount) ?? 0 }
        let viewModel = OperationsPieChartModel.Operations.ViewModel(operations: groupedOperations, pieChartData: pieChartData)
        viewController?.displayOperations(viewModel: viewModel)
        
    }
        
}
