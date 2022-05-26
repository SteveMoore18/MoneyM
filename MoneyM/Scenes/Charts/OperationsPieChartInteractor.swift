//
//  OperationsPieChartInteractor.swift
//  MoneyM
//
//  Created by Савелий Никулин on 23.05.2022.
//

import Foundation
import Charts

protocol OperationsPieChartLogic
{
    func groupOperations(request: OperationsPieChartModel.Operations.Request)
    func requestPieChartData(request: OperationsPieChartModel.PieChart.Request)
}

class OperationsPieChartInteractor
{
    
    var presenter: OperationsPieChartPresenter?
    
}

extension OperationsPieChartInteractor: OperationsPieChartLogic
{
    func requestPieChartData(request: OperationsPieChartModel.PieChart.Request) {
        
        let pieChartDataEntityArray = request.operations.map { operation -> PieChartDataEntry in
            let label = operation.categoryIcon + " " + operation.categoryTitle
            return PieChartDataEntry(value: Double(operation.amount) ?? 0, label: label)
        }
        
        let response = OperationsPieChartModel.PieChart.Response(operations: pieChartDataEntityArray)
        presenter?.presentPieChartData(response: response)
    }

    func groupOperations(request: OperationsPieChartModel.Operations.Request) {
        let response = OperationsPieChartModel.Operations.Response(operationsArray: request.operationsArray)
        presenter?.presentGroupedOperations(response: response)
    }
    
    
}
