//
//  Icons.swift
//  MoneyM
//
//  Created by Савелий Никулин on 15.01.2022.
//

import Foundation
import UIKit

class Icons {
	
	private(set) var icons: [UIImage] = []
	
	init() {
		initIcons()
	}
	
	private func initIcons() {
		icons.append(UIImage(systemName: "face.smiling")!)
		icons.append(UIImage(systemName: "paperplane")!)
		icons.append(UIImage(systemName: "archivebox")!)
		icons.append(UIImage(systemName: "doc")!)
		icons.append(UIImage(systemName: "note")!)
		icons.append(UIImage(systemName: "book")!)
		icons.append(UIImage(systemName: "bookmark")!)
		icons.append(UIImage(systemName: "graduationcap")!)
		icons.append(UIImage(systemName: "umbrella")!)
		icons.append(UIImage(systemName: "megaphone")!)
		icons.append(UIImage(systemName: "flag")!)
		icons.append(UIImage(systemName: "bell")!)
		icons.append(UIImage(systemName: "scissors")!)
		icons.append(UIImage(systemName: "amplifier")!)
		icons.append(UIImage(systemName: "pianokeys.inverse")!)
		icons.append(UIImage(systemName: "hammer")!)
		icons.append(UIImage(systemName: "case")!)
		icons.append(UIImage(systemName: "building")!)
		icons.append(UIImage(systemName: "lock.shield")!)
		icons.append(UIImage(systemName: "lock.open")!)
		icons.append(UIImage(systemName: "cpu")!)
		icons.append(UIImage(systemName: "headphones")!)
		icons.append(UIImage(systemName: "film")!)
		icons.append(UIImage(systemName: "crown")!)
		icons.append(UIImage(systemName: "shield")!)
		icons.append(UIImage(systemName: "clock")!)
		icons.append(UIImage(systemName: "gamecontroller")!)
		icons.append(UIImage(systemName: "gift")!)
		icons.append(UIImage(systemName: "lightbulb")!)
		icons.append(UIImage(systemName: "eye")!)
		icons.append(UIImage(systemName: "folder")!)
		icons.append(UIImage(systemName: "bolt")!)
		icons.append(UIImage(systemName: "sum")!)
		icons.append(UIImage(systemName: "x.squareroot")!)
        
        if #available(iOS 15, *)
        {
            icons.append(UIImage(systemName: "magazine")!)
            icons.append(UIImage(systemName: "globe.americas")!)
            icons.append(UIImage(systemName: "fuelpump")!)
        }
		
	}
	
}
