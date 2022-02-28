//
//  CurrencyViewController.swift
//  MoneyM
//
//  Created by Савелий Никулин on 14.01.2022.
//

import UIKit



protocol CurrencyDelegate {
	func currencySelected(currency: CurrencyModel.Model)
}

class CurrencyViewController: UIViewController {

	@IBOutlet weak var currenciesTableView: UITableView!
	
	public var delegate: CurrencyDelegate?

	private var currencyModel: CurrencyModel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		initCurrencies()
		tableViewInit()
    }
	
	// MARK: - private functions
	private func initCurrencies() {
		
		currencyModel = CurrencyModel()
		
		
	}
	
	private func tableViewInit() {
		currenciesTableView.delegate = self
		currenciesTableView.dataSource = self
	}
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - TableView delegate
extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let currency = currencyModel.currencies[indexPath.row]
		delegate?.currencySelected(currency: currency)
		dismiss(animated: true)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		currencyModel.currencies.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
		
		cell.textLabel?.text = currencyModel.currencies[indexPath.row].all
		
		return cell
	}
	
}
