//
//  SettingContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/02.
//

import SwiftUI
import WidgetKit

struct SettingContentView<SettingContentViewModel: ISettingContentViewModel>: View {
    @ObservedObject private var viewModel: SettingContentViewModel
    
    init(viewModel: SettingContentViewModel) {
        self.viewModel = viewModel
        
        UINavigationBar.appearance().titleTextAttributes = [
            .font : viewModel.getNaviFont(size: 16)
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : viewModel.getNaviFont(size: 32)
        ]
    }

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Library")
                        .font(viewModel.getFont(size: 16))
                        .foregroundColor(Color.text)
                    Spacer()
                    Text(viewModel.amount)
                        .font(.system(size: 16))
                        .foregroundColor(Color.text)
                }
                .listRowBackground(Color.layout)
                HStack {
                    Picker("Appearance", selection: $viewModel.colorSchemeMode) {
                        Text("Light").tag(ColorSchemeMode.light)
                            .foregroundColor(Color.text)
                        Text("Dark").tag(ColorSchemeMode.dark)
                            .foregroundColor(Color.text)
                    }
                    .onChange(of: viewModel.colorSchemeMode) { _ in
                        reloadAllTimelines()
                    }
                    .font(viewModel.getFont(size: 16))
                    .pickerStyle(.menu)
                }
                .listRowBackground(Color.layout)
                HStack {
                    Picker("Language", selection: $viewModel.languageMode) {
                        Text("Japanese").tag(LanguageMode.ja)
                            .foregroundColor(Color.text)
                        Text("English").tag(LanguageMode.en)
                            .foregroundColor(Color.text)
                    }
                    .onChange(of: viewModel.languageMode) { _ in
                        reloadAllTimelines()
                    }
                    .font(viewModel.getFont(size: 16))
                    .pickerStyle(.menu)
                }
                .listRowBackground(Color.layout)
                HStack {
                    Text("Version")
                        .font(viewModel.getFont(size: 16))
                        .foregroundColor(Color.text)
                    Spacer()
                    Text(viewModel.version)
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
        .environment(\.locale, .init(identifier: viewModel.getLanguageMode))
        .environment(\.colorScheme, viewModel.getColorScheme)
    }
    
    private func reloadAllTimelines() {
#if DEBUG
        WidgetCenter.shared.reloadAllTimelines()
#endif
    }
}

struct ContentView_Previews: PreviewProvider {
    private static let _entities = PokemonEntityPreviewFactory.createPreviewEntities()
    
    static var previews: some View {
        let jaViewModel = PreviewSettingContentViewModel(
            systemConfig: SystemConfig(languageMode: .ja, colorSchemeMode: .light),
            pokemonEntities: _entities,
            languageMode: .ja,
            colorSchemeMode: .light)
        let enViewModel = PreviewSettingContentViewModel(
            systemConfig: SystemConfig(languageMode: .en, colorSchemeMode: .dark),
            pokemonEntities: _entities,
            languageMode: .en,
            colorSchemeMode: .dark)
        
        Group {
            SettingContentView<PreviewSettingContentViewModel>(viewModel: jaViewModel)
            .previewDisplayName("Japanese")
            
            SettingContentView<PreviewSettingContentViewModel>(viewModel: enViewModel)
            .previewDisplayName("English")
            
            SettingContentView<PreviewSettingContentViewModel>(viewModel: jaViewModel)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE")
        }
    }
}
