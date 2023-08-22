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
        isJapanese ? "ja" : "en"
    }
    
    public var isJapanese: Bool {
        _locale.identifier.hasPrefix("ja")
    }
}
