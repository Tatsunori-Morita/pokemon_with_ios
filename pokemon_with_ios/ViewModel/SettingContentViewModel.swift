//
//  SettingContentViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/07/02.
//

import Foundation

struct SettingContentViewModel {
    private let _viewConfig: ViewConfig
    private let _pokemonEntities: [PokemonEntity]
    
    
    init(viewConfig: ViewConfig, pokemonEntities: [PokemonEntity]) {
        _viewConfig = viewConfig
        _pokemonEntities = pokemonEntities
    }
    
    public var amount: String {
        "\(_pokemonEntities.count) / \(_viewConfig.amount)"
    }
}
