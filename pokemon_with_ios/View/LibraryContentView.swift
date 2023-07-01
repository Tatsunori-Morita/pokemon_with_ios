//
//  LibraryContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct LibraryContentView: View {
    @ObservedObject var viewModel: LibraryContentViewModel = .init()
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name: "Hiragino Kaku Gothic ProN", size: 16)!
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name: "Hiragino Kaku Gothic ProN", size: 32)!
        ]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.data) { pokemon in
                        VStack(alignment: .leading, spacing: 0) {
                            WebImage(url: URL(string: pokemon.url))
                                .renderingMode(pokemon.isExist ? .original : .template)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.image)
                            Text(pokemon.no)
                                .font(.custom("SF Pro Text", size: 16))
                                .foregroundColor(Color.text)
                            Text(pokemon.name)
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
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
                    if viewModel.canLoadMore {
                        Text("Loading...")
                            .font(.custom("SF Pro Text", size: 16))
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
    }
}

struct LibraryContentView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryContentView()
            .environment(\.locale, .init(identifier: "en"))
        LibraryContentView()
            .environment(\.locale, .init(identifier: "ja"))
    }
}
