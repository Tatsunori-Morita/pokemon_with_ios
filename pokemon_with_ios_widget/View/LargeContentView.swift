//
//  WidgetLarge.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/16.
//

import SwiftUI

struct LargeContentView: View {
    let pokemonEntryViewModel: PokemonEntryViewModel
    
    var body: some View {
        VStack {
            CommonContentView(viewHelper: ViewHelper(
                pokemonEntryViewModel: pokemonEntryViewModel))
            Divider()
            Text(pokemonEntryViewModel.getJaFlavorTextEntry)
                .font(.system(size: 20))
                .lineSpacing(8)
                .foregroundColor(Color.text)
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Spacer()
        }
    }
}

struct WidgetLarge_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LargeContentView(
                pokemonEntryViewModel: PokemonEntryViewModel(
                    pokemon: LocalDataManager.shared.load(Pokemon.identifier),
                    pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
                pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier)))
            .environment(\.locale, .init(identifier: "en"))
            LargeContentView(
                pokemonEntryViewModel: PokemonEntryViewModel(
                    pokemon: LocalDataManager.shared.load(Pokemon.identifier),
                    pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
                    pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier)))
            .environment(\.locale, .init(identifier: "ja"))
        }
    }
}
