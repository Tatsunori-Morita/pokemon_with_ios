//
//  MainContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/24.
//

import SwiftUI

struct MainContentView<MainContentViewModel: IMainContentViewModel>: View {
    @ObservedObject var viewModel: MainContentViewModel
    
    var body: some View {
        let systemConfig = viewModel.getSystemConfig
        let pokemonEntities = viewModel.getPokemonEntities
        
        TabView {
            LibraryContentView(viewModel: LibraryContentViewModel(
                systemConfig: systemConfig,
                pokemonEntities: pokemonEntities))
                .tabItem {
                    Label("Library", systemImage: "book")
                        .environment(\.symbolVariants, .none)
                }
            
            SettingContentView<SettingContentViewModel>(viewModel: SettingContentViewModel(
                systemConfig: systemConfig,
                pokemonEntities: pokemonEntities))
                .tabItem {
                    Label("Setting", systemImage: "gear")
                        .environment(\.symbolVariants, .none)
                }
        }
        .accentColor(.accent)
        .environment(\.locale, .init(identifier: viewModel.getLanguageMode))
        .environment(\.colorScheme, viewModel.getColorScheme)
    }
}

struct MainContentView_Previews: PreviewProvider {
    private static let entities = PokemonEntityPreviewFactory.createPreviewEntities()
    
    static var previews: some View {
        let jaViewModel = PreviewMainContentViewModel(
            systemConfig: SystemConfig(languageMode: .ja, colorSchemeMode: .light),
            pokemonEntities: entities)
        let enViewModel = PreviewMainContentViewModel(
            systemConfig: SystemConfig(languageMode: .en, colorSchemeMode: .dark),
            pokemonEntities: entities)
        
        Group {
            MainContentView<PreviewMainContentViewModel>(viewModel: jaViewModel)
                .previewDisplayName("Japanese")
            
            MainContentView<PreviewMainContentViewModel>(viewModel: enViewModel)
                .previewDisplayName("English")
            
            MainContentView<PreviewMainContentViewModel>(viewModel: jaViewModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
                .previewDisplayName("iPhone SE")
        }
    }
}
