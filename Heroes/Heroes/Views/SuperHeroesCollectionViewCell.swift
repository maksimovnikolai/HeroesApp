//
//  SuperHeroesCollectionViewCell.swift
//  Heroes
//
//  Created by Nikolai Maksimov on 07.01.2024.
//

import UIKit

final class SuperHeroesCollectionViewCell: UICollectionViewCell {
    
    // MARK: Private properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public method
    func configure(_ hero: Superhero) {
        titleLabel.text = hero.name
        fetchImage(from: hero.images.lg)
    }
}

// MARK: - Private methods
private extension SuperHeroesCollectionViewCell {
    func commonInit() {
        setupImageViewConstraints()
        setupTitleLabelConstraints()
    }
    
    func fetchImage(from url: String) {
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let data):
                self.imageView.image = UIImage(data: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Constraints
private extension SuperHeroesCollectionViewCell {
    func setupImageViewConstraints() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupTitleLabelConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
