//
//  WidgetMedium.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/16.
//

import SwiftUI

struct WidgetMedium: View {
    let pokemonEntryViewModel: PokemonEntryViewModel

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("No.\(pokemonEntryViewModel.getId)")
                        .foregroundColor(.black)
                        .bold()
                    Text(pokemonEntryViewModel.getName)
                        .foregroundColor(.black)
                        .font(.system(size: 24))
                        .bold()
                        .padding(.bottom, 10)
                    Text(pokemonEntryViewModel.getGenera)
                        .foregroundColor(.black)
                    HStack {
                        Text("たかさ:")
                            .bold()
                            .foregroundColor(.black)
                        Text("\(pokemonEntryViewModel.getHeight)m")
                            .foregroundColor(.black)
                    }
                    HStack {
                        Text("おもさ:")
                            .bold()
                            .foregroundColor(.black)
                        Text("\(pokemonEntryViewModel.getWeight)kg")
                            .foregroundColor(.black)
                    }
                }

                Spacer()

                if let url = URL(string: pokemonEntryViewModel.getFrontDefault),
                   let imageData = try! Data(contentsOf: url),
                   let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
            .padding(.top, 10)
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .padding(.bottom, 10)

            Spacer()
        }
    }
}

struct WidgetMedium_Previews: PreviewProvider {
    static var previews: some View {
        WidgetMedium(
            pokemonEntryViewModel: PokemonEntryViewModel(
                pokemon: LocalDataManager.shared.loadPokemonData(),
                pokemonSpecies: LocalDataManager.shared.loadPokemonSpeciesData()))
    }
}
