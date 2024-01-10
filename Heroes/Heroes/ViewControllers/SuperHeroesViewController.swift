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
    private lazy var searchController = UISearchController(searchResultsController: nil)
    private lazy var scrollButton: UIButton = .getScrollButton(with: #selector(scrollContent))
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var superheroes = [Superhero]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var filteredHeroes = [Superhero]()
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewDidLayoutSubviews() {
        scrollButton.layer.cornerRadius = scrollButton.frame.width / 2
        scrollButton.clipsToBounds = true
        scrollButton.alpha = 0.7
    }
}

// MARK: - Private methods
private extension SuperHeroesViewController {
    
    func commonInit() {
        view.backgroundColor = .white
        setupSearchController()
        configureNavigationBar()
        setupDelegate()
        setupCollectionViewConstraints()
        setupScrolButton()
        fetchData()
    }
    
    func configureNavigationBar() {
        title = "FIND YOUR HERO"
        navigationController?.navigationBar.backgroundColor = .black
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
    
    @objc
    func scrollContent() {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension SuperHeroesViewController: UISearchResultsUpdating {
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        // цвет вводимого текста в searchBar
        UITextField.appearance(whenContainedInInstancesOf:
                [UISearchBar.self]).defaultTextAttributes = [.foregroundColor: UIColor.white]
        
        // цвет кнопки "Cancel" справа от searchBar'а
        UIBarButtonItem.appearance(whenContainedInInstancesOf:
                [UISearchBar.self]).tintColor = UIColor.gray
        
        // цвет placeholder-текста в searchBar'e
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search", attributes: [.foregroundColor: UIColor.gray]
        )
        
        // цвет значка поиска (лупы) в searchBar'e
        searchController.searchBar.searchTextField.leftView?.tintColor = .gray

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredHeroes = superheroes.filter({ superhero in
            return superhero.name.lowercased().contains(searchText.lowercased())
        })
        
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension SuperHeroesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? filteredHeroes.count : superheroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SuperHeroesCollectionViewCell else { return UICollectionViewCell() }
        
        let superhero = !isFiltering ? superheroes[indexPath.item] : filteredHeroes[indexPath.item]
        
        cell.configure(superhero)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SuperHeroesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let superhero = !isFiltering ? superheroes[indexPath.item] : filteredHeroes[indexPath.item]
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
    
    private func setupScrolButton() {
        view.addSubview(scrollButton)
        scrollButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            scrollButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            scrollButton.widthAnchor.constraint(equalToConstant: 50),
            scrollButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
