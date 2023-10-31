//
//  ViewConfig.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/07/02.
//

import SwiftUI

//struct ViewConfig {
//    private let _locale: Locale
//    private let _colorSchemeMode: ColorSchemeMode
//    private let _domainConfig: DomainConfig
//    private let _initialNumberOfPokemon = 21
//    private let _additionalNumberOfPokemon = 11
//    
//    init(locale: Locale, colorSchemeMode: ColorSchemeMode, domainConfig: DomainConfig) {
//        _locale = locale
//        _colorSchemeMode = colorSchemeMode
//        _domainConfig = domainConfig
//    }
//    
//    public var amount: Int {
//        _domainConfig.amount
//    }
//    
//    public var isDarkMode: Bool {
//        _colorSchemeMode == .dark
//    }
//    
//    public var language: String {
//        isJapanese ? _domainConfig.japanese : _domainConfig.english
//    }
//    
//    public var isJapanese: Bool {
//        _locale.identifier.hasPrefix(_domainConfig.japanese)
//    }
//
//    public var frontDefault: String {
//        _domainConfig.frontDefault
//    }
//    
//    public var initialNumberOfPokemon: Int {
//        _initialNumberOfPokemon
//    }
//    
//    public var additionalNumberOfPokemon: Int {
//        _additionalNumberOfPokemon
//    }
//    
//    var getLanguageMode: LanguageMode {
//        isJapanese ? .ja : .en
//    }
//    
//    var getColorScheme: ColorSchemeMode {
//        _colorSchemeMode
//    }
//}
