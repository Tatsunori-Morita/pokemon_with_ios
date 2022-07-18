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
            ContentWidget(pokemonEntryViewModel: pokemonEntryViewModel)
                .padding(.bottom, 30)
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
