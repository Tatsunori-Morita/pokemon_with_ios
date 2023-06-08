//
//  WidgetLarge.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/16.
//

import SwiftUI

struct LargeContentView: View {
    let viewHelper: ViewHelper
    
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 0) {
                VStack (alignment: .leading, spacing: 0) {
                    HStack (alignment: .top) {
                        VStack (alignment: .leading, spacing: 0) {
                            Text(viewHelper.id)
                                .font(.custom("SF Pro Text", size: 16))
                            Text(viewHelper.name)
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 20))
                                .bold()
                                .padding(.top, 5)
                        }
                        Spacer()
                        viewHelper.image
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
                            HStack (spacing: 5) {
                                ForEach(0..<viewHelper.types.count, id: \.self) { num in
                                    Text(viewHelper.types[num].name)
                                        .font(.custom("Hiragino Kaku Gothic ProN", size: 10))
                                        .foregroundColor(.white)
                                        .padding(.top, 4)
                                        .padding(.leading, 10)
                                        .padding(.trailing, 10)
                                        .padding(.bottom, 4)
                                        .background(.yellow)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        HStack (spacing: 0) {
                            Text("分類：")
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                                .bold()
                                .padding(.trailing, 16)
                            Text(viewHelper.genera)
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                        }
                        .padding(.top, 16)
                        HStack (spacing: 0) {
                            Text("高さ：")
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                                .bold()
                                .padding(.trailing, 16)
                            Text(viewHelper.height)
                                .font(.custom("SF Pro Text", size: 16))
                        }
                        .padding(.top, 16)
                        HStack (spacing: 0) {
                            Text("重さ：")
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                                .bold()
                                .padding(.trailing, 16)
                            Text(viewHelper.weight)
                                .font(.custom("SF Pro Text", size: 16))
                        }
                        .padding(.top, 16)
                    }
                    .padding(.top, 12)
                }
                Text(viewHelper.flavorTextEntry)
                    .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                    .lineSpacing(7)
                    .padding(.top, 32)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 56)
            .padding(.leading, 28)
            .padding(.trailing, 28)
            .padding(.bottom, 56)
        }
    }
}

struct WidgetLarge_Previews: PreviewProvider {
    static let dto = PokemonEntityDTO(
        pokemon: LocalDataManager.shared.load(Pokemon.identifier),
        pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
        pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier))
    
    static var previews: some View {
        Group {
            LargeContentView(
                viewHelper: ViewHelper(
                    pokemonEntity: dto.createEntity()))
            .environment(\.locale, .init(identifier: "ja"))
        }
    }
}
