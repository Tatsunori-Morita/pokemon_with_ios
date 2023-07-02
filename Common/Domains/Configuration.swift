//
//  Configuration.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/07/02.
//

import Foundation

struct Configuration {
    public let POKEMON_MAX_AMOUNT = 1010
    
    private let _locale: Locale
    private let _isDartModel: Bool
    
    init(locale: Locale, isDarkMode: Bool) {
        _locale = locale
        _isDartModel = isDarkMode
    }
    
    public var isDarkMode: Bool {
        _isDartModel
    }
    
    public var language: String {
        isJapanese ? "ja" : "en"
    }
    
    public var isJapanese: Bool {
        _locale.identifier.hasPrefix("ja")
    }
}
