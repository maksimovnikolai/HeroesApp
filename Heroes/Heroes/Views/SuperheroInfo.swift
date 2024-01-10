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
    lazy var appearanceStackView = UIStackView.getStackView()
    lazy var powerStatsStackView = UIStackView.getStackView()
    
    // Private properties
    private var superHero: Superhero
    
    // Init
    init(superhero: Superhero) {
        self.superHero = superhero
        configureBiographyStackView()
        configureAppearanceStackView()
        configurePowerStatsStackView()
    }
}

// MARK: - Private methods
private extension SuperheroInfo {
    
    // MARK: Biography Stack View
    func configureBiographyStackView() {
        let fullNameLabel: UILabel = .getLabel(title: "Full name: \(superHero.biography.fullName)")
        let alterEgoLabel: UILabel = .getLabel(title: "Alter Ego: \(superHero.biography.alterEgos)")
        let placeOfBirthLabel: UILabel = .getLabel(title: "Place of birth: \(superHero.biography.placeOfBirth)")
        [fullNameLabel, alterEgoLabel, placeOfBirthLabel].forEach { biographyStackView.addArrangedSubview($0) }
    }
    
    // MARK: Appearance Stack View
    func configureAppearanceStackView() {
        let race: UILabel = .getLabel(title: "Race: \(superHero.appearance.race ?? "unknown")")
        let height: UILabel = .getLabel(title: "Height: \(superHero.appearance.height.joined(separator: ", "))")
        let weight: UILabel = .getLabel(title: "Weight: \(superHero.appearance.weight.joined(separator: ", "))")
        let eyeColor: UILabel = .getLabel(title: "Eye color: \(superHero.appearance.eyeColor)")
        let hairColor: UILabel = .getLabel(title: "Hair color: \(superHero.appearance.hairColor)")
        [race, height, weight, eyeColor, hairColor].forEach { appearanceStackView.addArrangedSubview($0) }
    }
    
    // MARK: Power Stats Stack View
    func configurePowerStatsStackView() {
        let intelligence: UILabel = .getLabel(title: "intelligence: \(superHero.powerstats.intelligence)")
        let strength: UILabel = .getLabel(title: "Strength: \(superHero.powerstats.strength)")
        let speed: UILabel = .getLabel(title: "Speed: \(superHero.powerstats.speed)")
        let durability: UILabel = .getLabel(title: "Durability: \(superHero.powerstats.durability)")
        let power: UILabel = .getLabel(title: "Power: \(superHero.powerstats.power)")
        let combat: UILabel = .getLabel(title: "Combat: \(superHero.powerstats.combat)")
        [intelligence, strength, speed, durability, power, combat].forEach {
            powerStatsStackView.addArrangedSubview($0)
        }
    }
}
