//
//  PokemonContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/16.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonContentView<PokemonContentViewModel: IPokemonContentViewModel>: View {
    let viewModel: PokemonContentViewModel
    
    var body: some View {
        VStack (spacing: 0) {
            VStack (alignment: .leading, spacing: 0) {
                HStack (alignment: .top) {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(viewModel.id)
                            .font(.system(size: 16))
                        Text(viewModel.name)
                            .font(.custom("HiraginoSans-W6", size: 20))
                            .bold()
                            .padding(.top, 4)
                        if viewModel.isNew {
                            Text("New")
                                .font(.system(size: 12))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.top, 4)
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                                .padding(.bottom, 4)
                                .background(Color.new)
                                .cornerRadius(10)
                                .padding(.top, 16)
                        }
                    }
                    Spacer()
                    if viewModel.isApp {
                        WebImage(url: URL(string: viewModel.frontDefault))
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
                    } else {
                        viewModel.image
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
                            ForEach(viewModel.types) { pokemonTypeValue in
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
                        Text(viewModel.genera)
                            .font(.custom("HiraginoSans-W3", size: 16))
                    }
                    .padding(.top, 12)
                    if viewModel.isApp {
                        HStack (spacing: 0) {
                            Text("Height")
                                .font(.custom("HiraginoSans-W6", size: 16))
                                .bold()
                                .padding(.trailing, 16)
                            Text(viewModel.height)
                                .font(.system(size: 16))
                        }
                        .padding(.top, 8)
                        HStack (spacing: 0) {
                            Text("Weight")
                                .font(.custom("HiraginoSans-W6", size: 16))
                                .bold()
                                .padding(.trailing, 16)
                            Text(viewModel.weight)
                                .font(.system(size: 16))
                        }
                        .padding(.top, 8)
                    }
                }
                .padding(.top, 0)
            }
            Text(viewModel.flavorTextEntry)
                .fixedSize(horizontal: false, vertical: viewModel.isApp)
                .font(.custom("HiraginoSans-W3", size: 16))
                .lineSpacing(7)
                .padding(.top, 32)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if !viewModel.isApp {
                Spacer()
            }
        }
        .padding(24)
        .background(Color.layout)
        .environment(\.locale, .init(identifier: viewModel.getLanguageMode))
        .environment(\.colorScheme, viewModel.getColorScheme)
    }
}

struct WidgetContentView_Previews: PreviewProvider {
    private static let _entity = PokemonEntityPreviewFactory.createPreviewEntity()
    
    static var previews: some View {
        let jaViewModel = PreviewPokemonContentViewModel(
            systemConfig: SystemConfig(languageMode: .ja, colorSchemeMode: .light),
            pokemonEntity: _entity,
            isApp: false, isNew: true)
        let enViewModel = PreviewPokemonContentViewModel(
            systemConfig: SystemConfig(languageMode: .en, colorSchemeMode: .light),
            pokemonEntity: _entity,
            isApp: false, isNew: true)
        
        Group {
            PokemonContentView<PreviewPokemonContentViewModel>(viewModel: jaViewModel)
            .previewDisplayName("Japanese")
            
            PokemonContentView<PreviewPokemonContentViewModel>(viewModel: enViewModel)
            .previewDisplayName("English")
            
            PokemonContentView<PreviewPokemonContentViewModel>(viewModel: jaViewModel)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE")
        }
    }
}
