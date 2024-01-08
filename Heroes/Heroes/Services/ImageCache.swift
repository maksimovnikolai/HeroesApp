//
//  ImageCache.swift
//  Heroes
//
//  Created by Nikolai Maksimov on 08.01.2024.
//

import UIKit

final class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
