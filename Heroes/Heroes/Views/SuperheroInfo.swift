//
//  SuperheroInfo.swift
//  Heroes
//
//  Created by Nikolai Maksimov on 09.01.2024.
//

import UIKit

final class SuperheroInfo {
    
    // Public properties
    lazy var biographyStackView = UIStackView.getStackView()
    
    // Private properties
    private var superHero: Superhero

    // Init
    init(superhero: Superhero) {
        self.superHero = superhero
        configureBiographyStackView()
    }
}

// MARK: Private methods
private extension SuperheroInfo {

    func configureBiographyStackView() {
        let fullNameLabel: UILabel = .getLabel(title: "Full name: \(superHero.biography.fullName)")
        let alterEgoLabel: UILabel = .getLabel(title: "Alter Ego: \(superHero.biography.alterEgos)")
        let placeOfBirthLabel: UILabel = .getLabel(title: "Place of birth: \(superHero.biography.placeOfBirth)")
        [fullNameLabel, alterEgoLabel, placeOfBirthLabel].forEach { biographyStackView.addArrangedSubview($0) }
    }
}
