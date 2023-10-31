//
//  MainContentViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/10/31.
//

import SwiftUI

protocol IMainContentViewModel: ObservableObject {
    var colorSchemeMode: ColorSchemeMode { get set }
    var languageMode: LanguageMode { get set }
    var getColorScheme: ColorScheme { get }
    var getLanguageMode: String { get }
    var getSystemConfig: SystemConfig { get }
    var getPokemonEntities: [PokemonEntity] { get }
}

class MainContentViewModel: IMainContentViewModel {
    private let _pokemonEntities: [PokemonEntity] = RealmRepository().select()
    
    @AppStorage("colorSchemeMode", store: UserDefaults(suiteName: "group.com.tatsunori.morita.pokemon-with-ios"))
    var colorSchemeMode: ColorSchemeMode = .light
    
    @AppStorage("languageMode", store: UserDefaults(suiteName: "group.com.tatsunori.morita.pokemon-with-ios"))
    var languageMode: LanguageMode = .ja
    
    var getPokemonEntities: [PokemonEntity] {
        _pokemonEntities
    }
    
    var getSystemConfig: SystemConfig {
        SystemConfig(languageMode: languageMode, colorSchemeMode: colorSchemeMode)
    }
    
    var getColorScheme: ColorScheme {
        if colorSchemeMode == .light {
            return .light
        }
        return .dark
    }
    
    var getLanguageMode: String {
        languageMode.rawValue
    }
}

class PreviewMainContentViewModel: IMainContentViewModel {
//    private let _systemConfig: SystemConfig
    private let _pokemonEntities: [PokemonEntity]
    
    var colorSchemeMode: ColorSchemeMode = .light
    var languageMode: LanguageMode = .ja
    
    init(systemConfig: SystemConfig, pokemonEntities: [PokemonEntity]) {
//        _systemConfig = systemConfig
        colorSchemeMode = systemConfig.getColorScheme == .light ? .light : .dark
        languageMode = systemConfig.getLanguageMode == "ja" ? .ja : .en
        _pokemonEntities = pokemonEntities
    }
    
    var getPokemonEntities: [PokemonEntity] {
        _pokemonEntities
    }
    
    var getSystemConfig: SystemConfig {
        SystemConfig(languageMode: languageMode, colorSchemeMode: colorSchemeMode)
    }
    
    var getColorScheme: ColorScheme {
        if colorSchemeMode == .light {
            return .light
        }
        return .dark
    }
    
    var getLanguageMode: String {
        languageMode.rawValue
    }
}
