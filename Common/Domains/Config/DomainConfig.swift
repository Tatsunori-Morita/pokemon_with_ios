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
        return Const.shared.getPokemonAmount
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
