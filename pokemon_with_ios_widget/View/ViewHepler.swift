//
//  ViewHepler.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/08/03.
//

import Foundation
import SwiftUI

struct ViewHelper {
    private let _pokemonEntryViewModel: PokemonEntryViewModel

    init(pokemonEntryViewModel: PokemonEntryViewModel) {
        _pokemonEntryViewModel = pokemonEntryViewModel
    }

    public var getId: String {
        _pokemonEntryViewModel.getId
    }

    public var getName: String {
        _pokemonEntryViewModel.getName
    }

    public var getGenera: String {
        _pokemonEntryViewModel.getGenera
    }

    public var getHeight: String {
        _pokemonEntryViewModel.getHeight
    }

    public var getWeight: String {
        _pokemonEntryViewModel.getWeight
    }

    public var getTypeNames: String {
        _pokemonEntryViewModel.getTypeNames
    }

    public var getImage: Image {
        guard let url = URL(string: _pokemonEntryViewModel.getFrontDefault),
              let imageData = try? Data(contentsOf: url),
              let image = UIImage(data: imageData)
        else {
            return Image(uiImage: UIImage())
        }

        return Image(uiImage: image)
    }
}
