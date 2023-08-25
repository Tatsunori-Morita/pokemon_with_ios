//
//  ViewConfig.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/07/02.
//

import Foundation

struct ViewConfig {
    private let _locale: Locale
    private let _isDartMode: Bool
    private let _domainConfig: DomainConfig
    private let _version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
    private let _initialNumberOfPokemon = 21
    private let _additionalNumberOfPokemon = 11
    
    init(locale: Locale, isDarkMode: Bool, domainConfig: DomainConfig) {
        _locale = locale
        _isDartMode = isDarkMode
        _domainConfig = domainConfig
    }
    
    public var amount: Int {
        _domainConfig.amount
    }
    
    public var isDarkMode: Bool {
        _isDartMode
    }
    
    public var language: String {
        isJapanese ? _domainConfig.japanese : _domainConfig.english
    }
    
    public var isJapanese: Bool {
        _locale.identifier.hasPrefix(_domainConfig.japanese)
    }
    
    public var version: String {
        guard let value = _version as? String else { return "" }
        return value
    }
    
    public var frontDefault: String {
        _domainConfig.frontDefault
    }
    
    public var initialNumberOfPokemon: Int {
        _initialNumberOfPokemon
    }
    
    public var additionalNumberOfPokemon: Int {
        _additionalNumberOfPokemon
    }
}
