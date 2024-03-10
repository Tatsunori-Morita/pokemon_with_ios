//
//  LibraryContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct LibraryContentView: View {
    @Environment(\.viewController)
    private var viewControllerHolder: UIViewController?
    @ObservedObject
    private var viewModel: LibraryContentViewModel
    
    private let columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    init(viewModel: LibraryContentViewModel) {
        self.viewModel = viewModel
        
        UINavigationBar.appearance().titleTextAttributes = [
            .font : viewModel.getNaviFont(size: 16)
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : viewModel.getNaviFont(size: 32)
        ]
    }
    
    var body: some View {
        let systemConfig = viewModel.systemConfig
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.cellViewModels) { cellViewModel in
                        VStack(alignment: .leading, spacing: 0) {
                            ZStack {
                                WebImage(url: URL(string: cellViewModel.url))
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.image)
                                Rectangle()
                                    .fill(.black.opacity(cellViewModel.opacity))
                                    .mask {
                                        WebImage(url: URL(string: cellViewModel.url))
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(Color.image)
                                    }
                            }
                            Text(cellViewModel.no)
                                .font(.system(size: 16))
                                .foregroundColor(Color.text)
                            Text(cellViewModel.name)
                                .font(viewModel.getFont(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color.text)
                                .padding(.top, 4)
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .onTapGesture {
                            guard let entity = cellViewModel.entity else { return }
                            self.viewControllerHolder?.present(style: UIModalPresentationStyle.overCurrentContext, transitionStyle: UIModalTransitionStyle.crossDissolve) {
                                ModalPopUpView(systemConfig: systemConfig, entity: entity)
                            }
                        }
                    }
                    if viewModel.canLoadMore {
                        Text("Loading...")
                            .font(viewModel.getFont(size: 16))
                            .foregroundColor(Color.text)
                            .bold()
                            .onAppear {
                                viewModel.loadMore()
                            }
                    }
                }
            }
            .navigationTitle("Library")
            .background(Color.layout)
        }
        .onOpenURL(perform: { url in
            guard
                let num = Int(url.description),
                let entity = viewModel.getPokemonEntity(idValue: try! PokemonEntity.IdValue(id: num))
            else { return }
            self.viewControllerHolder?.present(style: UIModalPresentationStyle.overCurrentContext, transitionStyle: UIModalTransitionStyle.crossDissolve) {
                ModalPopUpView(systemConfig: systemConfig, entity: entity)
            }
        })
        .environment(\.locale, .init(identifier: systemConfig.getLanguage))
        .environment(\.colorScheme, systemConfig.getColorScheme)
    }
}

struct LibraryContentView_Previews: PreviewProvider {
    private static let entities = PokemonEntityPreviewFactory.createPreviewEntities()
    
    static var previews: some View {
        let jaViewModel = LibraryContentViewModel(
            systemConfig: SystemConfig(languageMode: .ja, colorSchemeMode: .light),
            pokemonEntities: entities)
        let enViewModel = LibraryContentViewModel(
            systemConfig: SystemConfig(languageMode: .en, colorSchemeMode: .dark),
            pokemonEntities: entities)
        
        LibraryContentView(viewModel: jaViewModel)
        .previewDisplayName("Japanese")
        
        LibraryContentView(viewModel: enViewModel)
        .previewDisplayName("English")
        
        LibraryContentView(viewModel: jaViewModel)
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        .previewDisplayName("iPhone SE")
    }
}
