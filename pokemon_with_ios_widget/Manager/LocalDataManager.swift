//
//  LocalDataManager.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/16.
//

import Foundation

struct LocalDataManager {
    public static let shared = LocalDataManager()

    public func loadPokemonData() -> Pokemon {
        guard let url = Bundle.main.url(forResource: "Pokemon", withExtension: "json") else {
            fatalError()
        }

        guard
            let data = try? Data(contentsOf: url),
            let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data)
        else {
            fatalError()
        }
        return pokemon
    }

    public func loadPokemonSpeciesData() -> PokemonSpecies {
        guard let url = Bundle.main.url(forResource: "PokemonSpecies", withExtension: "json") else {
            fatalError()
        }

        guard
            let data = try? Data(contentsOf: url),
            let pokemonSpecies = try? JSONDecoder().decode(PokemonSpecies.self, from: data)
        else {
            fatalError()
        }
        return pokemonSpecies
    }

    public func loadPokemonTypesData() -> [PokemonType] {
        guard let url = Bundle.main.url(forResource: "PokemonTypes", withExtension: "json") else {
            fatalError()
        }

        guard
            let data = try? Data(contentsOf: url),
            let pokemonTypes = try? JSONDecoder().decode([PokemonType].self, from: data)
        else {
            fatalError()
        }
        return pokemonTypes
    }
}
