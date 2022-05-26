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
    
    struct OperationPresentModel
    {
        var categoryIcon: String
        var categoryTitle: String
        var amount: String
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
        }
    }
    
    struct PieChart
    {
        struct Request
        {
            var operations: [OperationPresentModel]
        }
        
        struct Response
        {
            var operations: [PieChartDataEntry]
        }
        
        struct ViewModel
        {
            var pieChartData: PieChartData
        }
    }
    
}
