//
//  EditAccountInteractor.swift
//  MoneyM
//
//  Created by Савелий Никулин on 16.06.2022.
//

import Foundation
import UIKit

protocol EditAccountLogic
{
    func editAccountClicked(request: EditAccountModel.EditAccount.Request)
}

class EditAccountInteractor
{
    
    var presenter: EditAccountPresentLogic?
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

extension EditAccountInteractor: EditAccountLogic
{
    func editAccountClicked(request: EditAccountModel.EditAccount.Request) {
        let account = request.account
        
        account.title = request.title
        account.balance = Int64(request.balance)
        account.colorID = Int64(request.colorID)
        account.iconID = Int64(request.iconID)
        account.currencyID = Int64(request.currencyID)
        
        
        do
        {
            try context.save()
        } catch
        {
            print ("Error with editing account")
        }
        
        let response = EditAccountModel.EditAccount.Response()
        presenter?.presentEditedAccount(response: response)
    }
    
}
