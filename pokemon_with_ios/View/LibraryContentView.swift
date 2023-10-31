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
    private var _viewControllerHolder: UIViewController?
    @ObservedObject
    private var _viewModel: LibraryContentViewModel
    
    private let _columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    init(viewModel: LibraryContentViewModel) {
        _viewModel = viewModel
        
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name: "HiraginoSans-W6", size: 16)!
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name: "HiraginoSans-W6", size: 32)!
        ]
    }
    
    var body: some View {
        let systemConfig = _viewModel.systemConfig
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: _columns, spacing: 0) {
                    ForEach(_viewModel.cellViewModels) { cellViewModel in
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
                                .font(.custom("HiraginoSans-W6", size: 16))
                                .foregroundColor(Color.text)
                                .bold()
                                .padding(.top, 4)
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .onTapGesture {
                            guard let entity = cellViewModel.entity else { return }
                            self._viewControllerHolder?.present(style: UIModalPresentationStyle.overCurrentContext, transitionStyle: UIModalTransitionStyle.crossDissolve) {
                                ModalPopUpView(systemConfig: systemConfig, entity: entity)
                            }
                        }
                    }
                    if _viewModel.canLoadMore {
                        Text("Loading...")
                            .font(.custom("HiraginoSans-W6", size: 16))
                            .foregroundColor(Color.text)
                            .bold()
                            .onAppear {
                                _viewModel.loadMore()
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
                let entity = _viewModel.getPokemonEntity(idValue: try! PokemonEntity.IdValue(id: num))
            else { return }
            self._viewControllerHolder?.present(style: UIModalPresentationStyle.overCurrentContext, transitionStyle: UIModalTransitionStyle.crossDissolve) {
                ModalPopUpView(systemConfig: systemConfig, entity: entity)
            }
        })
        .environment(\.locale, .init(identifier: systemConfig.getLanguageMode))
        .environment(\.colorScheme, systemConfig.getColorScheme)
    }
}

struct LibraryContentView_Previews: PreviewProvider {
    private static let _entities = PokemonEntityPreviewFactory.createPreviewEntities()
    
    static var previews: some View {
        let jaViewModel = LibraryContentViewModel(
            systemConfig: SystemConfig(languageMode: .ja, colorSchemeMode: .light),
            pokemonEntities: _entities)
        let enViewModel = LibraryContentViewModel(
            systemConfig: SystemConfig(languageMode: .en, colorSchemeMode: .dark),
            pokemonEntities: _entities)
        
        LibraryContentView(viewModel: jaViewModel)
        .previewDisplayName("Japanese")
        
        LibraryContentView(viewModel: enViewModel)
        .previewDisplayName("English")
        
        LibraryContentView(viewModel: jaViewModel)
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        .previewDisplayName("iPhone SE")
    }
}
