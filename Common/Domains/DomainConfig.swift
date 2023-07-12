//
//  DomainConfig.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/07/13.
//

import Foundation

struct DomainConfig {
    private let POKEMON_AMOUNT = 1010
    private let POKEMON_URL = "https://pokeapi.co/api/v2/pokemon/"
    private let POKEMON_SPECIES_URL = "https://pokeapi.co/api/v2/pokemon-species/"
    private let _number: Int
    
    init() {
        _number = Int.random(in: 1 ... POKEMON_AMOUNT)
    }
    
    public var number: Int {
        _number
    }
    
    public var amount: Int {
        POKEMON_AMOUNT
    }
    
    public var pokemonUrl: String {
        "\(POKEMON_URL)\(_number)"
    }
    
    public var speciesUrl: String {
        "\(POKEMON_SPECIES_URL)\(_number)"
    }
}
