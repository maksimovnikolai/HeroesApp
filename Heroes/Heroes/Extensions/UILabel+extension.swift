//
//  UILabel+extension.swift
//  Heroes
//
//  Created by Nikolai Maksimov on 09.01.2024.
//

import UIKit

extension UILabel {
    
    static func getLabel(title: String? = nil, size: CGFloat? = nil, textColor: UIColor? = nil) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "Marker Felt Wide", size: size ?? 16)
        label.textColor = textColor ?? .cyan
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
}
