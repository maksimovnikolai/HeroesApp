//
//  UILabel+extension.swift
//  Heroes
//
//  Created by Nikolai Maksimov on 09.01.2024.
//

import UIKit

extension UILabel {
    
    static func getLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "Marker Felt Wide", size: 16)
        label.textColor = .cyan
        return label
    }
}
