//
//  EditAccountModel.swift
//  MoneyM
//
//  Created by Савелий Никулин on 16.06.2022.
//

import Foundation

struct EditAccountModel
{
    
    struct EditAccount
    {
        struct Request {
            var account: AccountEntity
            var title: String
            var balance: Int
            var iconID: Int
            var colorID: Int
            var currencyID: Int
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
}
