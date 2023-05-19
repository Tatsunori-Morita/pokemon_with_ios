//
//  Species.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/15.
//

import Foundation

struct PokemonSpecies: Codable {
    let baseHappiness, captureRate: Int?
    let color: Species?
    let eggGroups: [Species]?
    let evolutionChain: EvolutionChain?
    let evolvesFromSpecies: Species?
    let flavorTextEntries: [FlavorTextEntry]?
    let formsSwitchable: Bool?
    let genderRate: Int?
    let genera: [Genus]?
    let generation, growthRate, habitat: Species?
    let hasGenderDifferences: Bool?
    let hatchCounter, id: Int?
    let isBaby, isLegendary, isMythical: Bool?
    let name: String?
    let names: [Name]?
    let order: Int?
    let palParkEncounters: [PalParkEncounter]?
    let pokedexNumbers: [PokedexNumber]?
    let shape: Species?
    let varieties: [Variety]?

    enum CodingKeys: String, CodingKey {
        case baseHappiness = "base_happiness"
        case captureRate = "capture_rate"
        case color
        case eggGroups = "egg_groups"
        case evolutionChain = "evolution_chain"
        case evolvesFromSpecies = "evolves_from_species"
        case flavorTextEntries = "flavor_text_entries"
        case formsSwitchable = "forms_switchable"
        case genderRate = "gender_rate"
        case genera, generation
        case growthRate = "growth_rate"
        case habitat
        case hasGenderDifferences = "has_gender_differences"
        case hatchCounter = "hatch_counter"
        case id
        case isBaby = "is_baby"
        case isLegendary = "is_legendary"
        case isMythical = "is_mythical"
        case name, names, order
        case palParkEncounters = "pal_park_encounters"
        case pokedexNumbers = "pokedex_numbers"
        case shape, varieties
    }
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let url: String?
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String?
    let language, version: Species?

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }

    public var getFlavorText: String {
        flavorText ?? ""
    }
}

// MARK: - Genus
struct Genus: Codable {
    let genus: String?
    let language: Species?

    public var getGenus: String {
        genus ?? ""
    }
}

// MARK: - Name
struct Name: Codable {
    let language: Species?
    let name: String?

    public var getName: String {
        name ?? ""
    }
}

// MARK: - PalParkEncounter
struct PalParkEncounter: Codable {
    let area: Species?
    let baseScore, rate: Int?

    enum CodingKeys: String, CodingKey {
        case area
        case baseScore = "base_score"
        case rate
    }
}

// MARK: - PokedexNumber
struct PokedexNumber: Codable {
    let entryNumber: Int?
    let pokedex: Species?

    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokedex
    }
}

// MARK: - Variety
struct Variety: Codable {
    let isDefault: Bool?
    let pokemon: Species?

    enum CodingKeys: String, CodingKey {
        case isDefault = "is_default"
        case pokemon
    }
}

extension PokemonSpecies {
    public static let identifier = String(describing: PokemonSpecies.self)
}
