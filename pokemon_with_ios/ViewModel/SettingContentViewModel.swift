//
//  SettingContentViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/07/02.
//

import Foundation

struct SettingContentViewModel {
    private let _configuration: Configuration
    private let _pokemonEntities: [PokemonEntity]
    
    
    init(configuration: Configuration, pokemonEntities: [PokemonEntity]) {
        _configuration = configuration
        _pokemonEntities = pokemonEntities
    }
    
    public var amount: String {
        "\(_pokemonEntities.count) / \(1010)"
    }
}
