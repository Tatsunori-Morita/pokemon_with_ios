//
//  SettingContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/02.
//

import SwiftUI

struct SettingContentView: View {
    private let _version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
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
                    Text("Version")
                        .font(.custom("HiraginoSans-W3", size: 16))
                        .foregroundColor(Color.text)
                    Spacer()
                    Text(_version)
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
}

struct ContentView_Previews: PreviewProvider {
    @Environment(\.colorScheme)
    private static var _colorScheme
    private static let _entities = RealmRepository().select()
    private static let _domainConfig = DomainConfig()
    
    static var previews: some View {
        Group {
            SettingContentView(viewModel: SettingContentViewModel(
                viewConfig: ViewConfig(
                    locale: Locale(identifier: "ja_jp"),
                    isDarkMode: _colorScheme == .dark,
                    domainConfig: _domainConfig),
                pokemonEntities: _entities))
            .environment(\.locale, .init(identifier: "ja"))
            
            SettingContentView(viewModel: SettingContentViewModel(
                viewConfig: ViewConfig(
                    locale: Locale(identifier: "en_jp"),
                    isDarkMode: _colorScheme == .dark,
                    domainConfig: _domainConfig),
                pokemonEntities: _entities))
            .environment(\.locale, .init(identifier: "en"))
        }
    }
}
