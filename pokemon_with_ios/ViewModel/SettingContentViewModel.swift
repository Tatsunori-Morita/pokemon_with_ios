//
//  SettingContentViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/07/02.
//

import SwiftUI

protocol ISettingContentViewModel: ObservableObject {
    var amount: String { get }
    var version: String { get }
    var colorSchemeMode: ColorSchemeMode { get set }
    var languageMode: LanguageMode { get set }
    var getColorScheme: ColorScheme { get }
    var getLanguageMode: String { get }
    func getFont(size: CGFloat) -> Font
}

class SettingContentViewModel: ISettingContentViewModel {
    private let _systemConfig: SystemConfig
    private let _pokemonEntities: [PokemonEntity]
    
    @AppStorage("colorSchemeMode", store: UserDefaults(suiteName: "group.com.tatsunori.morita.pokemon-with-ios"))
    var colorSchemeMode: ColorSchemeMode = .light
    
    @AppStorage("languageMode", store: UserDefaults(suiteName: "group.com.tatsunori.morita.pokemon-with-ios"))
    var languageMode: LanguageMode = .ja
    
    var getColorScheme: ColorScheme {
        if colorSchemeMode == .light {
            return .light
        }
        return .dark
    }
    
    var getLanguageMode: String {
        languageMode.rawValue
    }
    
    init(systemConfig: SystemConfig, pokemonEntities: [PokemonEntity]) {
        _systemConfig = systemConfig
        _pokemonEntities = pokemonEntities
    }
    
    public var amount: String {
        "\(_pokemonEntities.count) / \(_systemConfig.getAmount)"
    }
    
    public var version: String {
        guard
            let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        else {
            return ""
        }
        return version
    }
    
    func getFont(size: CGFloat) -> Font {
        _systemConfig.getLanguageMode == .ja ? Font.custom("HiraginoSans-W3", size: size) : Font.system(size: size)
    }
}

class PreviewSettingContentViewModel: ISettingContentViewModel {
    private let _systemConfig: SystemConfig
    private let _pokemonEntities: [PokemonEntity]
    
    @Published var colorSchemeMode: ColorSchemeMode = .light
    @Published var languageMode: LanguageMode

    var getColorScheme: ColorScheme {
        if colorSchemeMode == .light {
            return .light
        }
        return .dark
    }
    
    var getLanguageMode: String {
        languageMode.rawValue
    }
    
    init(
        systemConfig: SystemConfig, pokemonEntities: [PokemonEntity],
        languageMode: LanguageMode, colorSchemeMode: ColorSchemeMode) {
        _systemConfig = systemConfig
        _pokemonEntities = pokemonEntities
        self.languageMode = languageMode
        self.colorSchemeMode = colorSchemeMode
    }
    
    var amount: String {
        "999 / \(_systemConfig.getAmount)"
    }
    
    var version: String {
        "9.9.9"
    }
    
    func getFont(size: CGFloat) -> Font {
        _systemConfig.getLanguageMode == .ja ? Font.custom("HiraginoSans-W3", size: size) : Font.system(size: size)
    }
}
