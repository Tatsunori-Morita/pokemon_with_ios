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
            CommonContentView(pokemonEntryViewModel: pokemonEntryViewModel)
            Divider()
            Text(pokemonEntryViewModel.getFlavorTextEntry)
                .font(.system(size: 20))
                .lineSpacing(8)
                .foregroundColor(Color.text)
                .padding(.top)
            Spacer()
        }
    }
}

struct WidgetLarge_Previews: PreviewProvider {
    static var previews: some View {
        LargeContentView(
            pokemonEntryViewModel: PokemonEntryViewModel(
                pokemon: LocalDataManager.shared.loadPokemonData(),
                pokemonSpecies: LocalDataManager.shared.loadPokemonSpeciesData()))
    }
}
