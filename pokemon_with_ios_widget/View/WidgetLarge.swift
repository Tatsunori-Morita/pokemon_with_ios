//
//  WidgetLarge.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/16.
//

import SwiftUI

struct WidgetLarge: View {
    let pokemonEntryViewModel: PokemonEntryViewModel
    
    var body: some View {
        VStack {
            ContentWidget(pokemonEntryViewModel: pokemonEntryViewModel)
            Divider()
            Text(pokemonEntryViewModel.getFlavorTextEntry)
                .font(.system(size: 20))
                .lineSpacing(8)
                .foregroundColor(.black)
                .padding(.top)
            Spacer()
        }
    }
}

struct WidgetLarge_Previews: PreviewProvider {
    static var previews: some View {
        WidgetLarge(
            pokemonEntryViewModel: PokemonEntryViewModel(
                pokemon: LocalDataManager.shared.loadPokemonData(),
                pokemonSpecies: LocalDataManager.shared.loadPokemonSpeciesData()))
    }
}
