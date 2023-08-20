//
//  PokemonEntityPreviewFactory.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/08/20.
//

import Foundation

struct PokemonEntityPreviewFactory {
    private static let _pokemons = [
        "pikachu",
        "bulbasaur",
        "caterpie"
    ]
    
    public static func createPreviewEntity() -> PokemonEntity {
        let name = _pokemons[0]
        let factory = PokemonEntityFactory(
            pokemon: LocalDataManager.shared.load("Pokemon_\(name)"),
            pokemonSpecies: LocalDataManager.shared.load("PokemonSpecies_\(name)"),
            pokemonTypes: LocalDataManager.shared.load("PokemonType_\(name)")
        )
        return factory.createEntity()
    }
    
    public static func createPreviewEntities() -> [PokemonEntity] {
        return _pokemons.map {
            PokemonEntityFactory(
                pokemon: LocalDataManager.shared.load("Pokemon_\($0)"),
                pokemonSpecies: LocalDataManager.shared.load("PokemonSpecies_\($0)"),
                pokemonTypes: LocalDataManager.shared.load("PokemonType_\($0)")
            ).createEntity()
        }
    }
}
