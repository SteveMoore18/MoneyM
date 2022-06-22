//
//  EditAccountViewController.swift
//  MoneyM
//
//  Created by Савелий Никулин on 16.06.2022.
//

import UIKit

protocol EditAccountDisplayLogic
{
    func displayEditedAccount(viewModel: EditAccountModel.EditAccount.ViewModel)
}

protocol EditAccountDelegate
{
    func accountDidEdit()
}

class EditAccountViewController: NewAccountViewController {

    private var interactor: EditAccountLogic?
	private var currencyModel: CurrencyModel!
	
    var account: AccountEntity?
    
    var editAccountDelegate: EditAccountDelegate?
    
    override func viewDidLoad() {
        // CleanSwift setup
        setup()
        
        loadData()
		
		super.viewDidLoad()
    }
    
    override func localizeText() {
        super.localizeText()
        navigationBar.topItem?.title = NSLocalizedString("edit.account", comment: "")
		btnCreate.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
    }

    override func createButtonClicked(_ sender: Any) {
        let title = titleTextField.text!
        let balance = Int(balanceTextField.text!) ?? 0
        let iconID = selectedIconIndex?.row ?? 0
		let colorID: Int = selectedColorIndex?.row ?? 0
        
        let request = EditAccountModel.EditAccount.Request(account: account!,
                                                           title: title,
                                                           balance: balance,
                                                           iconID: iconID,
                                                           colorID: colorID,
                                                           currencyID: selectedCurrencyID)
        interactor?.editAccountClicked(request: request)
        editAccountDelegate?.accountDidEdit()
    }
    
    // MARK: - Private func
    private func setup() {
        let viewController = self
        let editAccountInteractor = EditAccountInteractor()
        let editAccountPresenter = EditAccountPresenter()
        
        editAccountInteractor.presenter = editAccountPresenter
        editAccountPresenter.viewController = viewController
        
        interactor = editAccountInteractor
    }
    
    private func loadData()
    {
		currencyModel = CurrencyModel()
        
        if let account = account
        {
            titleTextField.text = account.title
            balanceTextField.text = String(account.balance)
            selectedColorIndex = IndexPath(row: Int(account.colorID), section: 0)
			selectedIconIndex = IndexPath(row: Int(account.iconID), section: 0)
			currencyButtonTitle = currencyModel.currencyBy(id: Int(account.currencyID))?.all
        }
        
    }
    
    
}

// MARK: - Display logic
extension EditAccountViewController: EditAccountDisplayLogic
{
    func displayEditedAccount(viewModel: EditAccountModel.EditAccount.ViewModel) {
        dismiss(animated: true)
    }
    
    
}
