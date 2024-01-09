//
//  SuperHeroDetailsViewController.swift
//  Heroes
//
//  Created by Nikolai Maksimov on 09.01.2024.
//

import UIKit

final class SuperHeroDetailsViewController: UIViewController {
    
    // MARK: Public properties
    var superhero: Superhero!
    
    // MARK: Private properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

// MARK: Private methods
private extension SuperHeroDetailsViewController {
    
    func commonInit() {
        view.backgroundColor = .black
        setupImageViewConstraints()
        getImageFromCache(superhero.images.lg)
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.title = superhero.name
        navigationItem.hidesBackButton = true
    }
    
    func getImageFromCache(_ url: String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let image = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}

// MARK: Constraints
private extension SuperHeroDetailsViewController {
    func setupImageViewConstraints() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}
