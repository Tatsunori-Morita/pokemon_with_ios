//
//  Const.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/11/13.
//

import Foundation

struct Const {
    public static let shared = Const()
    
    public var getPokemonAmount: Int {
        1010
    }
    
    public var getPokemonUrl: String {
        "https://pokeapi.co/api/v2/pokemon/"
    }
    
    public var getPokemonSpeciesUrl: String {
        "https://pokeapi.co/api/v2/pokemon-species/"
    }
    
    public var getPokemonFrontDefault: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%@.png"
    }
}
