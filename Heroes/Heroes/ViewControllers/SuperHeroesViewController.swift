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
        configureNavigationBar()
        setupDelegate()
        setupCollectionViewConstraints()
        fetchData()
    }
    
    func configureNavigationBar() {
        title = "FIND YOUR HERO"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [
            .font: UIFont(name: "Chalkduster", size: 24) ?? "",
            .foregroundColor: UIColor.red
        ]
        navBarAppearance.backgroundColor = .black
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func fetchData() {
        NetworkManager.shared.fetchData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let superheroes):
                self.superheroes = superheroes
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
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
        let superhero = superheroes[indexPath.item]
        cell.configure(superhero)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SuperHeroesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let superhero = superheroes[indexPath.item]
        let detailVC = SuperHeroDetailsViewController()
        detailVC.superhero = superhero
        navigationController?.pushViewController(detailVC, animated: true)
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
