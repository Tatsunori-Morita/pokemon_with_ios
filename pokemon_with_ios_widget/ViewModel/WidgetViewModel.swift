//
//  WidgetViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/10/31.
//

import SwiftUI

protocol IWidgetViewModel: ObservableObject {
    var colorSchemeMode: ColorSchemeMode { get set }
    var languageMode: LanguageMode { get set }
    var getColorScheme: ColorScheme { get }
    var getLanguageMode: String { get }
    var getSystemConfig: SystemConfig { get }
}

class WidgetViewModel: IWidgetViewModel {
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
    
    var getSystemConfig: SystemConfig {
        SystemConfig(languageMode: languageMode, colorSchemeMode: colorSchemeMode)
    }
}

class PreviewWidgetViewModel: IWidgetViewModel {
    var colorSchemeMode: ColorSchemeMode = .light
    var languageMode: LanguageMode = .ja
    
    init(systemConfig: SystemConfig) {
        colorSchemeMode = systemConfig.getColorScheme == .light ? .light : .dark
        languageMode = systemConfig.getLanguage == "ja" ? .ja : .en
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
    
    var getSystemConfig: SystemConfig {
        SystemConfig(languageMode: languageMode, colorSchemeMode: colorSchemeMode)
    }
}
