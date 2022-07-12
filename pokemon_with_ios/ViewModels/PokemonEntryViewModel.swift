//
//  PokemonEntryViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/12.
//

import Foundation

class PokemonEntryViewModel {
    private var _pokemon: Pokemon!

    init(pokemon: Pokemon? = nil) {
        _pokemon = pokemon
    }

    public var getId: String {
        guard let value = _pokemon.id else {
            return ""
        }
        return value.description
    }

    public var getName: String {
        guard let value = _pokemon.name else {
            return ""
        }
        return value
    }

    public var getFrontDefault: String {
        guard let pokemon = _pokemon, let value = pokemon.sprites?.getFrontDefault else {
            return ""
        }
        return value
    }
}
