//
//  UIImageView+extension.swift
//  Heroes
//
//  Created by Nikolai Maksimov on 10.01.2024.
//

import UIKit

extension UIImageView {
    
    static func getImageView() -> UIImageView{
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }
}
