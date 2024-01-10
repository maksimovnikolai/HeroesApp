//
//  UIButton+extension.swift
//  Heroes
//
//  Created by Nikolai Maksimov on 10.01.2024.
//

import UIKit

extension UIButton {
    
    static func getButton(with action: Selector) -> UIButton {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "RETURN"
        button.configuration?.attributedTitle?.font = UIFont(name: "Marker Felt Wide", size: 20)
        button.configuration?.baseForegroundColor = .red
        button.configuration?.baseBackgroundColor = .clear
        button.configuration?.image = UIImage(systemName: "arrowshape.left.fill")
        button.configuration?.imagePadding = 10
        button.addTarget(nil, action: action, for: .touchUpInside)
        return button
    }
}
