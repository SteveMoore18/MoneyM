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
    func requestData(request: OperationsPieChartModel.Operations.Request)
}

class OperationsPieChartInteractor
{
    
    var presenter: OperationsPieChartPresenter?
    
}

extension OperationsPieChartInteractor: OperationsPieChartLogic
{
    func requestData(request: OperationsPieChartModel.Operations.Request) {
        let response = OperationsPieChartModel.Operations.Response(operationsArray: request.operationsArray)
        presenter?.presentData(response: response)
    }
    
    
}
