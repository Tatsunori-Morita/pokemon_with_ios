//
//  MainContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/24.
//

import SwiftUI

struct MainContentView: View {
    @Environment(\.locale)
    private var _locale: Locale
    @Environment(\.colorScheme)
    private var _colorScheme
    private let _pokemonEntities = RealmRepository().select()
    private let _domainConfig = DomainConfig()
    
    var body: some View {
        TabView {
            LibraryContentView(viewModel: LibraryContentViewModel(
                viewConfig: ViewConfig(
                    locale: _locale,
                    isDarkMode: _colorScheme == .dark,
                    domainConfig: _domainConfig),
                pokemonEntities: _pokemonEntities))
                .tabItem {
                    Label("Library", systemImage: "book")
                        .environment(\.symbolVariants, .none)
                }
            
            SettingContentView(viewModel: SettingContentViewModel(
                viewConfig: ViewConfig(
                    locale: _locale,
                    isDarkMode: _colorScheme == .dark,
                    domainConfig: _domainConfig),
                pokemonEntities: _pokemonEntities))
                .tabItem {
                    Label("Setting", systemImage: "gear")
                        .environment(\.symbolVariants, .none)
                }
        }
        .accentColor(.accent)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainContentView()
                .environment(\.locale, .init(identifier: "ja"))
            
            MainContentView()
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
