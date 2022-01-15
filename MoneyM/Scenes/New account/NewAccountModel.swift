//
//  NewAccountModel.swift
//  MoneyM
//
//  Created by Савелий Никулин on 11.01.2022.
//

import Foundation
import UIKit

class NewAccountModel {
	
	struct Colors {
		
		struct Request {
			
		}
		
		struct Response {
			var colors: [UIColor]
		}
		
		struct ViewModel {
			var colors: [UIColor]
		}
		
	}
	
	struct Icons {
		struct Request {
			
		}
		
		struct Response {
			var icons: [UIImage]
		}
		
		struct ViewModel {
			var icons: [UIImage]
		}
	}
	
	struct CreateAccount {
		
		struct Request {
			var title: String
			var balance: Int
			var iconID: Int
			var colorID: Int
		}
		
		struct Response {
			
		}
		
		struct ViewModel {
			
		}
		
	}
	
}
