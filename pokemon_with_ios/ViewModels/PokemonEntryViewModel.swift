//
//  PokemonEntryViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/12.
//

import Foundation

class PokemonEntryViewModel {
    private var _pokemon: Pokemon

    init(pokemon: Pokemon) {
        _pokemon = pokemon
    }

    public var getId: String {
        guard let value = _pokemon.id else {
            return ""
        }
        return String(format: "%03d", value)
    }

    public var getName: String {
        guard let value = _pokemon.name else {
            return ""
        }
        return value
    }

    public var getFrontDefault: String {
        guard let value = _pokemon.sprites?.getFrontDefault else {
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
}
