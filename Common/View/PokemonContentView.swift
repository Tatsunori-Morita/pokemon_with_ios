//
//  PokemonContentView.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/16.
//

import SwiftUI

struct PokemonContentView: View {
    let viewModel: PokemonContentViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 0) {
                VStack (alignment: .leading, spacing: 0) {
                    HStack (alignment: .top) {
                        VStack (alignment: .leading, spacing: 0) {
                            Text(viewModel.id)
                                .font(.custom("SF Pro Text", size: 16))
                            Text(viewModel.name)
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 20))
                                .bold()
                                .padding(.top, 4)
                        }
                        Spacer()
                        viewModel.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
                    }
                    VStack (alignment: .leading, spacing: 0) {
                        HStack {
                            Text("タイプ：")
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                                .bold()
                                .padding(.trailing, 16)
                            HStack (spacing: 8) {
                                ForEach(0..<viewModel.types.count, id: \.self) { index in
                                    Text(viewModel.typeName(index: index))
                                        .font(.custom("Hiragino Kaku Gothic ProN", size: 10))
                                        .foregroundColor(.white)
                                        .padding(.top, 4)
                                        .padding(.leading, 10)
                                        .padding(.trailing, 10)
                                        .padding(.bottom, 4)
                                        .background(viewModel.typeColor(index: index))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.top, 8)
                        HStack (spacing: 0) {
                            Text("分類：")
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                                .bold()
                                .padding(.trailing, 16)
                            Text(viewModel.genera)
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                        }
                        .padding(.top, 12)
                        if viewModel.isApp {
                            HStack (spacing: 0) {
                                Text("高さ：")
                                    .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                                    .bold()
                                    .padding(.trailing, 16)
                                Text(viewModel.height)
                                    .font(.custom("SF Pro Text", size: 16))
                            }
                            .padding(.top, 8)
                            HStack (spacing: 0) {
                                Text("重さ：")
                                    .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                                    .bold()
                                    .padding(.trailing, 16)
                                Text(viewModel.weight)
                                    .font(.custom("SF Pro Text", size: 16))
                            }
                            .padding(.top, 8)
                        }
                    }
                    .padding(.top, 0)
                }
                Text(viewModel.flavorTextEntry)
                    .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                    .lineSpacing(7)
                    .padding(.top, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(24)
        }
    }
}

struct WidgetContentView_Previews: PreviewProvider {
    static let dto = PokemonEntityDTO(
        pokemon: LocalDataManager.shared.load(Pokemon.identifier),
        pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
        pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier))
    
    static var previews: some View {
        Group {
            PokemonContentView(
                viewModel: PokemonContentViewModel(
                    pokemonEntity: dto.createEntity(), isApp: false))
            .environment(\.locale, .init(identifier: "ja"))
        }
    }
}
