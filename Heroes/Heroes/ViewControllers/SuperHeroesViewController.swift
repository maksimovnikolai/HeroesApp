//
//  SuperHeroesViewController.swift
//  Heroes
//
//  Created by Nikolai Maksimov on 07.01.2024.
//

import UIKit

final class SuperHeroesViewController: UIViewController {
    
    // MARK: Private properties
    private lazy var collectionView = makeCollectionView()
    
    private var superheroes = [Superhero]() {
        didSet {
            collectionView.reloadData()
            print(superheroes)
        }
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

// MARK: - Private methods
private extension SuperHeroesViewController {
    
     func commonInit() {
         setupDelegate()
         setupCollectionViewConstraints()
    }
    
    func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .yellow
        collectionView.register(SuperHeroesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }
}


// MARK: - UICollectionViewDataSource
extension SuperHeroesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        superheroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SuperHeroesCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .red
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SuperHeroesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width/2 - 16, height: 260)
    }
}

// MARK: - Constraints
extension SuperHeroesViewController {
    
    private func setupCollectionViewConstraints() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

