//
//  PokemonContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/16.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonContentView: View {
    private let _viewModel: PokemonContentViewModel
    
    init(viewModel: PokemonContentViewModel) {
        _viewModel = viewModel
    }
    
    var body: some View {
        VStack (spacing: 0) {
            VStack (alignment: .leading, spacing: 0) {
                HStack (alignment: .top) {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(_viewModel.id)
                            .font(.system(size: 16))
                        Text(_viewModel.name)
                            .font(.custom("HiraginoSans-W6", size: 20))
                            .bold()
                            .padding(.top, 4)
                    }
                    Spacer()
                    if _viewModel.isApp {
                        WebImage(url: URL(string: _viewModel.frontDefault))
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
                    } else {
                        _viewModel.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
                    }
                }
                VStack (alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Type")
                            .font(.custom("HiraginoSans-W6", size: 16))
                            .bold()
                            .padding(.trailing, 16)
                        HStack (spacing: 8) {
                            ForEach(_viewModel.types) { pokemonTypeValue in
                                Text(pokemonTypeValue.name)
                                    .font(.custom("HiraginoSans-W6", size: 10))
                                    .foregroundColor(.white)
                                    .padding(.top, 4)
                                    .padding(.leading, 10)
                                    .padding(.trailing, 10)
                                    .padding(.bottom, 4)
                                    .background(try! PokemonColor.shared.getColorType(name: pokemonTypeValue.name).color)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.top, 8)
                    HStack (spacing: 0) {
                        Text("Genre")
                            .font(.custom("HiraginoSans-W6", size: 16))
                            .bold()
                            .padding(.trailing, 16)
                        Text(_viewModel.genera)
                            .font(.custom("HiraginoSans-W3", size: 16))
                    }
                    .padding(.top, 12)
                    if _viewModel.isApp {
                        HStack (spacing: 0) {
                            Text("Height")
                                .font(.custom("HiraginoSans-W6", size: 16))
                                .bold()
                                .padding(.trailing, 16)
                            Text(_viewModel.height)
                                .font(.system(size: 16))
                        }
                        .padding(.top, 8)
                        HStack (spacing: 0) {
                            Text("Weight")
                                .font(.custom("HiraginoSans-W6", size: 16))
                                .bold()
                                .padding(.trailing, 16)
                            Text(_viewModel.weight)
                                .font(.system(size: 16))
                        }
                        .padding(.top, 8)
                    }
                }
                .padding(.top, 0)
            }
            Text(_viewModel.flavorTextEntry)
                .font(.custom("HiraginoSans-W3", size: 16))
                .lineSpacing(7)
                .padding(.top, 32)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(24)
    }
}

struct WidgetContentView_Previews: PreviewProvider {
    @Environment(\.colorScheme)
    private static var colorScheme
    
    static let factory = PokemonEntityFactory(
        pokemon: LocalDataManager.shared.load(Pokemon.identifier),
        pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
        pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier))
    
    static var previews: some View {
        Group {
            PokemonContentView(viewModel: PokemonContentViewModel(
                viewConfig: ViewConfig(
                    locale: Locale(identifier: "ja_jp"),
                    isDarkMode: colorScheme == .dark,
                    domainConfig: DomainConfig()),
                pokemonEntity: factory.createEntity(),
                isApp: false))
                .environment(\.locale, .init(identifier: "ja"))
            
            PokemonContentView(viewModel: PokemonContentViewModel(
                viewConfig: ViewConfig(
                    locale: Locale(identifier: "en_jp"),
                    isDarkMode: colorScheme == .dark,
                    domainConfig: DomainConfig()),
                pokemonEntity: factory.createEntity(),
                isApp: false))
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
