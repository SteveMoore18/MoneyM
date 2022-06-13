//
//  OperationsPieChartModel.swift
//  MoneyM
//
//  Created by Савелий Никулин on 23.05.2022.
//

import Foundation
import Charts

struct OperationsPieChartModel
{
    
    struct Data
    {
        var operationsArray: [OperationEntity]
        var currency: CurrencyModel.Model
    }
    
    struct OperationPresentModel
    {
        var categoryIcon: String
        var categoryTitle: String
        var amount: String
        var color: NSUIColor
    }
    
    struct Operations
    {
        struct Request
        {
            var operationsArray: [OperationEntity]
        }
        
        struct Response
        {
            var operationsArray: [OperationEntity]
        }
        
        struct ViewModel
        {
            var operations: [OperationPresentModel]
            var pieChartData: PieChartData
        }
    }
    
}
