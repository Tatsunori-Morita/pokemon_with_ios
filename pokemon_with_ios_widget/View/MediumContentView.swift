//
//  WidgetMedium.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/16.
//

import SwiftUI

struct MediumContentView: View {
    let pokemonEntryViewModel: PokemonEntryViewModel

    var body: some View {
        VStack {
            CommonContentView(pokemonEntryViewModel: pokemonEntryViewModel)
                .padding(.bottom, 30)
        }
    }
}

struct WidgetMedium_Previews: PreviewProvider {
    static var previews: some View {
        MediumContentView(
            pokemonEntryViewModel: PokemonEntryViewModel(
                pokemon: LocalDataManager.shared.load(Pokemon.identifier),
                pokemonSpecies: LocalDataManager.shared.load(PokemonSpecies.identifier),
                pokemonTypes: LocalDataManager.shared.load(PokemonType.identifier)))
    }
}
