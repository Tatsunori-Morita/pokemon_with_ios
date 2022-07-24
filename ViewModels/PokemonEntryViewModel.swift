//
//  PokemonEntryViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/12.
//

import Foundation

class PokemonEntryViewModel {
    private let _pokemon: Pokemon
    private let _pokemonSpecies: PokemonSpecies
    private let _pokemonTypes: [PokemonType]

    init(pokemon: Pokemon, pokemonSpecies: PokemonSpecies, pokemonTypes: [PokemonType]) {
        _pokemon = pokemon
        _pokemonSpecies = pokemonSpecies
        _pokemonTypes = pokemonTypes
    }

    public var getId: String {
        guard let value = _pokemon.id else {
            return ""
        }
        return String(format: "%03d", value)
    }

    public var getName: String {
        guard
            let names = _pokemonSpecies.names,
            let name = names.filter({ $0.language?.name == "ja" }).first
        else {
            return ""
        }
        return name.getName
    }

    public var getFrontDefault: String {
        guard let value = _pokemon.sprites?.other?.officialArtwork?.getFrontDefault else {
            return ""
        }
        return value
    }

    public var getHeight: String {
        let value = Double(_pokemon.getHeight) / 10
        return String(format: "%.1f", value)
    }

    public var getWeight: String {
        let value = Double(_pokemon.getWeight) / 10
        return String(format: "%.1f", value)
    }

    public var getGenera: String {
        guard
            let generas = _pokemonSpecies.genera,
            let genera = generas.filter({ $0.language?.name == "ja"}).first
        else {
            return ""
        }
        return genera.getGenus
    }

    public var getFlavorTextEntry: String {
        guard
            let flavorTextEntries = _pokemonSpecies.flavorTextEntries,
            let flavorTextEntry = flavorTextEntries.filter({ $0.language?.name == "ja" }).last
        else {
            return ""
        }
        return flavorTextEntry.getFlavorText
    }

    public var getTypeNames: String {
        var arry: [String] = []
        _pokemonTypes.forEach { pokemonType in
            if let typeName = pokemonType.names?.filter({ $0.language?.name == "ja" }).first {
                arry.append(typeName.getName)
            }
        }
        return arry.joined(separator: "/")
    }
}
