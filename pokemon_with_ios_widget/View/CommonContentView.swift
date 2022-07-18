//
//  ContentWidget.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/18.
//

import SwiftUI

struct CommonContentView: View {
    let pokemonEntryViewModel: PokemonEntryViewModel
    
    var body: some View {
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
                        .foregroundColor(.black)
                    Text("\(pokemonEntryViewModel.getHeight)m")
                        .foregroundColor(.black)
                }
                HStack {
                    Text("おもさ:")
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
        .padding(.top, 30)
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}

struct ContentWidget_Previews: PreviewProvider {
    static var previews: some View {
        CommonContentView(pokemonEntryViewModel: PokemonEntryViewModel(
            pokemon: LocalDataManager.shared.loadPokemonData(),
            pokemonSpecies: LocalDataManager.shared.loadPokemonSpeciesData()))
    }
}
