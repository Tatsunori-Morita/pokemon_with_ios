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
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                Text("No.\(pokemonEntryViewModel.getId)")
                    .foregroundColor(Color.text)
                    .bold()
                Text(pokemonEntryViewModel.getName)
                    .foregroundColor(Color.text)
                    .font(.system(size: 24))
                    .bold()
                    .padding(.bottom, 10)
                Text(pokemonEntryViewModel.getGenera)
                    .foregroundColor(Color.text)
                HStack {
                    Text("Height")
                        .foregroundColor(Color.text)
                    Text("\(pokemonEntryViewModel.getHeight)m")
                        .foregroundColor(Color.text)
                }
                HStack {
                    Text("Weight")
                        .foregroundColor(Color.text)
                    Text("\(pokemonEntryViewModel.getWeight)kg")
                        .foregroundColor(Color.text)
                }
            }

            Spacer()

            VStack {
                if let url = URL(string: pokemonEntryViewModel.getFrontDefault),
                   let imageData = try! Data(contentsOf: url),
                   let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                Text(pokemonEntryViewModel.getTypeNames)
                    .font(.system(size: 12))
                    .bold()
                    .padding(5)
                    .foregroundColor(Color.layout)
                    .background(Color.text)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding(.top, 20)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

struct ContentWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CommonContentView(pokemonEntryViewModel: PokemonEntryViewModel(
                pokemon: LocalDataManager.shared.load(Pokemon.identifier),
                pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
            pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier)))
            .environment(\.locale, .init(identifier: "en"))
            CommonContentView(pokemonEntryViewModel: PokemonEntryViewModel(
                pokemon: LocalDataManager.shared.load(Pokemon.identifier),
                pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
                pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier)))
            .environment(\.locale, .init(identifier: "ja"))
        }
    }
}
