//
//  DomainConfig.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/07/13.
//

import SwiftUI

class SystemConfig {
    private let _languageMode: LanguageMode
    private let _colorSchemeMode: ColorSchemeMode
    
    init(languageMode: LanguageMode, colorSchemeMode: ColorSchemeMode) {
        _languageMode = languageMode
        _colorSchemeMode = colorSchemeMode
    }
    
    var getAmount: Int {
        return 1010
    }
    
    var getLanguage: String {
        _languageMode.rawValue
    }
    
    var getLanguageMode: LanguageMode {
        _languageMode
    }
    
    var getColorSchemeMode: ColorSchemeMode {
        _colorSchemeMode
    }
    
    var getColorScheme: ColorScheme {
        if _colorSchemeMode == .light {
            return .light
        }
        return .dark
    }
}

class LibraryContentViewConfig: SystemConfig {
    private let _initialNumberOfPokemon = 21
    private let _additionalNumberOfPokemon = 11
    
    public var initialNumberOfPokemon: Int {
        _initialNumberOfPokemon
    }
    
    public var additionalNumberOfPokemon: Int {
        _additionalNumberOfPokemon
    }
}

struct DomainConfig {
    private let _pokemonAmount = 1010
    private let _pokemonUrl = "https://pokeapi.co/api/v2/pokemon/"
    private let _pokemonSpeciesUrl = "https://pokeapi.co/api/v2/pokemon-species/"
    private let _pokemonFrontDefault = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%@.png"
    private let _number: Int
    
    init() {
        _number = Int.random(in: 1 ... _pokemonAmount)
    }
    
    public var number: Int {
        _number
    }
    
    public var amount: Int {
        _pokemonAmount
    }
    
    public var pokemonUrl: String {
        "\(_pokemonUrl)\(_number)"
    }
    
    public var speciesUrl: String {
        "\(_pokemonSpeciesUrl)\(_number)"
    }
    
    public var frontDefault: String {
        _pokemonFrontDefault
    }
    
    public var japanese: String {
        return "ja"
    }
    
    public var english: String {
        return "en"
    }
    
    public var japaneseInJapan: String {
        return "\(japanese)_jp"
    }
    
    public var englishInJapane: String {
        return "\(english)_jp"
    }
}
