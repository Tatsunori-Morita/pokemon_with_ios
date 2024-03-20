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

    @State private var offsetY: CGFloat = 0
    @State private var rotationDegrees: Double = 0
    @State private var shadowWidth: Double = 1.5

    private var rotateAnimation: Animation {
        .easeOut
        .speed(0.3)
        .repeatForever(autoreverses: false)
    }

    private var moveAnimation: Animation {
        .easeOut
        .speed(0.3)
        .repeatForever(autoreverses: true)
    }

    private var shadowAnimation: Animation {
        .easeOut
        .speed(0.3)
        .repeatForever(autoreverses: true)
    }

    var body: some View {
        VStack (spacing: 0) {
            VStack (alignment: .leading, spacing: 0) {
                HStack (alignment: .top) {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(viewModel.id)
                            .font(.system(size: 16))
                        Text(viewModel.name)
                            .font(viewModel.getFont(size: 20))
                            .fontWeight(.medium)
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
                            .placeholder {
                                VStack (spacing: 3) {
                                    Spacer()
                                    Image("Icon")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(15)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(.black, lineWidth: 2)
                                        }
                                        .rotationEffect(.degrees(rotationDegrees))
                                        .offset(y: offsetY)
                                        .onAppear {
                                            withAnimation(rotateAnimation) {
                                                rotationDegrees = 360
                                            }

                                            withAnimation(moveAnimation) {
                                                offsetY = -50
                                            }
                                        }
                                    Rectangle()
                                        .fill(Color(red: 13/255, green: 1/255, blue: 22/255))
                                        .frame(width: 13, height: 1)
                                        .cornerRadius(5)
                                        .scaleEffect(shadowWidth)
                                        .onAppear {
                                            withAnimation(shadowAnimation) {
                                                shadowWidth = 1
                                            }
                                        }
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
                            }
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
                            .font(viewModel.getFont(size: 16))
                            .padding(.trailing, 16)
                        HStack (spacing: 8) {
                            ForEach(viewModel.types) { pokemonTypeValue in
                                Text(pokemonTypeValue.name)
                                    .font(viewModel.getFont(size: 10))
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
                            .font(viewModel.getFont(size: 16))
                            .padding(.trailing, 16)
                        Text(viewModel.genera)
                            .font(viewModel.getFont(size: 16))
                    }
                    .padding(.top, 12)
                    if viewModel.isApp {
                        HStack (spacing: 0) {
                            Text("Height")
                                .font(viewModel.getFont(size: 16))
                                .padding(.trailing, 16)
                            Text(viewModel.height)
                                .font(.system(size: 16))
                        }
                        .padding(.top, 8)
                        HStack (spacing: 0) {
                            Text("Weight")
                                .font(viewModel.getFont(size: 16))
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
                .font(viewModel.getFont(size: 16))
                .lineSpacing(7)
                .padding(.top, 32)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if !viewModel.isApp {
                Spacer()
            }
        }
        .background(Color.layout)
        .environment(\.locale, .init(identifier: viewModel.getLanguageMode))
        .environment(\.colorScheme, viewModel.getColorScheme)
    }
}

struct WidgetContentView_Previews: PreviewProvider {
    private static let entity = PokemonEntityPreviewFactory.createPreviewEntity()
    
    static var previews: some View {
        let jaViewModel = PreviewPokemonContentViewModel(
            systemConfig: SystemConfig(languageMode: .ja, colorSchemeMode: .light),
            pokemonEntity: entity,
            isNew: true)
        let enViewModel = PreviewPokemonContentViewModel(
            systemConfig: SystemConfig(languageMode: .en, colorSchemeMode: .light),
            pokemonEntity: entity,
            isNew: true)
        
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
