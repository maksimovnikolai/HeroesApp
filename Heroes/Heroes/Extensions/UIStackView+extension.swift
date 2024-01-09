//
//  UIStackView+extension.swift
//  Heroes
//
//  Created by Nikolai Maksimov on 09.01.2024.
//

import UIKit

extension UIStackView {
    
    static func getStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }
}
