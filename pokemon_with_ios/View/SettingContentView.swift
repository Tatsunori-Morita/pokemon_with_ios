//
//  SettingContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/02.
//

import SwiftUI
import WidgetKit

struct SettingContentView: View {
    @AppStorage("colorSchemeMode", store: UserDefaults(suiteName: "group.com.tatsunori.morita.pokemon-with-ios"))
    private var _selectedColorSchemeMode: ColorSchemeMode = .light
    private let _viewModel: SettingContentViewModel
    
    init(viewModel: SettingContentViewModel) {
        _viewModel = viewModel
        
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name: "HiraginoSans-W6", size: 16)!
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name: "HiraginoSans-W6", size: 32)!
        ]
    }

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Library")
                        .font(.custom("HiraginoSans-W3", size: 16))
                        .foregroundColor(Color.text)
                    Spacer()
                    Text(_viewModel.amount)
                        .font(.system(size: 16))
                        .foregroundColor(Color.text)
                }
                .listRowBackground(Color.layout)
                HStack {
                    Picker("Appearance", selection: $_selectedColorSchemeMode) {
                        Text("Light").tag(ColorSchemeMode.light)
                            .foregroundColor(Color.text)
                        Text("Dark").tag(ColorSchemeMode.dark)
                            .foregroundColor(Color.text)
                    }
                    .onChange(of: _selectedColorSchemeMode) { _ in
                        reloadAllTimelines()
                    }
                    .font(.custom("HiraginoSans-W3", size: 16))
                    .pickerStyle(.menu)
                }
                .listRowBackground(Color.layout)
                HStack {
                    Text("Version")
                        .font(.custom("HiraginoSans-W3", size: 16))
                        .foregroundColor(Color.text)
                    Spacer()
                    Text(_viewModel.version)
                        .font(.system(size: 16))
                        .foregroundColor(Color.text)
                }
                .listRowBackground(Color.layout)
                HStack {
                    Text("Created by")
                        .font(.system(size: 16))
                        .foregroundColor(Color.text)
                    Spacer()
                    Text("Tatsunori")
                        .font(.system(size: 16))
                        .foregroundColor(Color.text)
                }
                .listRowBackground(Color.layout)
            }
            .listStyle(.plain)
            .background(Color.layout)
            .navigationTitle("Setting")
        }
    }
    
    private func reloadAllTimelines() {
#if DEBUG
        WidgetCenter.shared.reloadAllTimelines()
#endif
    }
}

struct ContentView_Previews: PreviewProvider {
    @Environment(\.colorScheme)
    private static var _colorScheme
    private static let _entities = PokemonEntityPreviewFactory.createPreviewEntities()
    private static let _domainConfig = DomainConfig()
    
    static var previews: some View {
        Group {
            SettingContentView(viewModel: SettingContentViewModel(
                viewConfig: ViewConfig(
                    locale: Locale(identifier: _domainConfig.japaneseInJapan),
                    isDarkMode: _colorScheme == .dark,
                    domainConfig: _domainConfig),
                pokemonEntities: _entities))
            .environment(\.locale, .init(identifier: _domainConfig.japanese))
            .previewDisplayName("Japanese")
            
            SettingContentView(viewModel: SettingContentViewModel(
                viewConfig: ViewConfig(
                    locale: Locale(identifier: _domainConfig.englishInJapane),
                    isDarkMode: _colorScheme == .dark,
                    domainConfig: _domainConfig),
                pokemonEntities: _entities))
            .environment(\.locale, .init(identifier: _domainConfig.english))
            .previewDisplayName("English")
            
            SettingContentView(viewModel: SettingContentViewModel(
                viewConfig: ViewConfig(
                    locale: Locale(identifier: _domainConfig.japaneseInJapan),
                    isDarkMode: _colorScheme == .dark,
                    domainConfig: _domainConfig),
                pokemonEntities: _entities))
            .environment(\.locale, .init(identifier: _domainConfig.japanese))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE")
        }
    }
}
