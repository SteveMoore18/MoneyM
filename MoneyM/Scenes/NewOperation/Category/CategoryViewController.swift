//
//  CategoryViewController.swift
//  MoneyM
//
//  Created by Савелий Никулин on 19.01.2022.
//

import UIKit

protocol CategoryDelegate {
	func categorySelected(category: CategoryModel.Model)
}

class CategoryViewController: UIViewController {

	public var operationMode: NewOperationModel.OperationMode = .Expense
	
	public var delegate: CategoryDelegate?
	
	public var categoryModel: CategoryModel!
	
	// MARK: - Outlets
	@IBOutlet weak var categoriesTableView: UITableView!
	
	// MARK: - Privtae variables
	private var categories: [CategoryModel.Model] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        otherInit()
    }
	
	// MARK: - Private functions
	private func otherInit() {
		
		categoriesTableView.delegate = self
		categoriesTableView.dataSource = self
		
		if categoryModel == nil {
			categoryModel = CategoryModel()
		}
		
		categories = categoryModel.categories(mode: operationMode)
	}
    
	// MARK: - Actions
	@IBAction func closeButtonClicked(_ sender: Any) {
		dismiss(animated: true)
	}
	
}

// MARK: - Category TableView delegate
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		categories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UICategoryTableViewCell
		
		let category = categories[indexPath.row]
		
		cell.iconLabel.text = category.emojiIcon
		cell.titleLabel.text = category.title
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let category = categories[indexPath.row]
		delegate?.categorySelected(category: category)
		
		dismiss(animated: true)
	}
	
}
