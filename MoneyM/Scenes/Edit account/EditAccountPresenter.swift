//
//  EditAccountPresenter.swift
//  MoneyM
//
//  Created by Савелий Никулин on 16.06.2022.
//

import Foundation

protocol EditAccountPresentLogic
{
    func presentEditedAccount(response: EditAccountModel.EditAccount.Response)
}

class EditAccountPresenter
{

    var viewController: EditAccountDisplayLogic?
    
}

extension EditAccountPresenter: EditAccountPresentLogic
{
    func presentEditedAccount(response: EditAccountModel.EditAccount.Response) {
        let viewModel = EditAccountModel.EditAccount.ViewModel()
        viewController?.displayEditedAccount(viewModel: viewModel)
    }
    
    
}
