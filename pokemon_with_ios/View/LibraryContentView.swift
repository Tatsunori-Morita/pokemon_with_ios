//
//  LibraryContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct LibraryContentView: View {
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @ObservedObject private var _viewModel: LibraryContentViewModel
    private let columns = [GridItem(.flexible()),
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
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(_viewModel.data) { pokemon in
                        VStack(alignment: .leading, spacing: 0) {
                            ZStack {
                                WebImage(url: URL(string: pokemon.url))
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.image)
                                Rectangle()
                                    .fill(.black.opacity(pokemon.isExist ? 0 : 0.8))
                                    .mask {
                                        WebImage(url: URL(string: pokemon.url))
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(Color.image)
                                    }
                            }
                            Text(pokemon.no)
                                .font(.system(size: 16))
                                .foregroundColor(Color.text)
                            Text(pokemon.name)
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
                            guard let entity = pokemon._entity else { return }
                            self.viewControllerHolder?.present(style: UIModalPresentationStyle.overCurrentContext, transitionStyle: UIModalTransitionStyle.crossDissolve) {
                                ModalPopUpView(entity: entity)
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
    }
}

struct LibraryContentView_Previews: PreviewProvider {
    private static let entities = RealmRepository().select()
    
    static var previews: some View {
        LibraryContentView(
            viewModel: LibraryContentViewModel(
                configuration: Configuration(
                    locale: Locale(identifier: "en_jp")),
                pokemonEntities: entities))
            .environment(\.locale, .init(identifier: "en"))
        LibraryContentView(
            viewModel: LibraryContentViewModel(
                configuration: Configuration(
                    locale: Locale(identifier: "ja_jp")),
                pokemonEntities: entities))
            .environment(\.locale, .init(identifier: "ja"))
    }
}
