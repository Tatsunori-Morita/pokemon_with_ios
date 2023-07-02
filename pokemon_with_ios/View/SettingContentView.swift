//
//  SettingContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/02.
//

import SwiftUI

struct SettingContentView: View {
    private let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    @Environment(\.locale) private var locale: Locale
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
                    Text(version)
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
            .navigationTitle("Setting")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @Environment(\.colorScheme)
    private static var colorScheme
    private static let entities = RealmRepository().select()
    
    static var previews: some View {
        Group {
            SettingContentView(viewModel: SettingContentViewModel(
                configuration: Configuration(
                    locale: Locale(identifier: "js_jp"), isDarkMode: colorScheme == .dark),
                pokemonEntities: entities))
            .environment(\.locale, .init(identifier: "js"))
            
            SettingContentView(viewModel: SettingContentViewModel(
                configuration: Configuration(
                    locale: Locale(identifier: "en_jp"), isDarkMode: colorScheme == .dark),
                pokemonEntities: entities))
            .environment(\.locale, .init(identifier: "en"))
        }
    }
}
