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
    private lazy var imageView: UIImageView = .getImageView()
    private lazy var backButton: UIButton = .getButton(with: #selector(closeVC))
    private lazy var segmentedControl: UISegmentedControl = makeSegmentedControl()
    private lazy var superheroInfo = SuperheroInfo(superhero: superhero)
    
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
        setupNavigationBar()
        setupImageViewConstraints()
        setupBackButtonConstraints()
        setupSegmentedControlConstraints()
        setupStackViewConstraint(
            superheroInfo.biographyStackView,
            superheroInfo.appearanceStackView,
            superheroInfo.powerStatsStackView
        )
        getImageFromCache(superhero.images.lg)
    }
    
    func setupNavigationBar() {
        navigationItem.title = superhero.name
        navigationItem.hidesBackButton = true
    }
    
    @objc
    func closeVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func segmentChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            showStackView(superheroInfo.biographyStackView)
        case 1:
            showStackView(superheroInfo.appearanceStackView)
            
        default:
            showStackView(superheroInfo.powerStatsStackView)
        }
    }
    
    func showStackView(_ stackView: UIStackView) {
        [superheroInfo.powerStatsStackView,
         superheroInfo.appearanceStackView,
         superheroInfo.biographyStackView].forEach { $0.isHidden = true }
        stackView.isHidden = false
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

// MARK: - Create UI element
private extension SuperHeroDetailsViewController {
    func makeSegmentedControl() -> UISegmentedControl {
        let items = ["Biography", "Appearance", "Powerstats"]
        let sc = UISegmentedControl(items: items)
        sc.backgroundColor = .red
        sc.selectedSegmentTintColor = .yellow
        sc.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
        return sc
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
    
    func setupBackButtonConstraints() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupSegmentedControlConstraints() {
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupStackViewConstraint(_ superheroStack: UIView...) {
        superheroStack.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            $0.isHidden = true
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
                $0.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor),
            ])
        }
    }
}
