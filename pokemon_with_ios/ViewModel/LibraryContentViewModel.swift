//
//  LibraryContentViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/26.
//

import Foundation
import SwiftUI

class LibraryContentViewModel: ObservableObject {
    @Published var data: [LibraryContentCellViewModel] = []
    
    private let _viewConfig: ViewConfig
    public let _pokemonEntities: [PokemonEntity]
    
    init(viewConfig: ViewConfig, pokemonEntities: [PokemonEntity]) {
        _viewConfig = viewConfig
        _pokemonEntities = pokemonEntities
        
        for i in 1..<21 {
            data.append(LibraryContentCellViewModel(
                id: i, entity: pokemonEntity(num: i), viewConfig: _viewConfig))
        }
    }
    
    public var viewConfig: ViewConfig {
        _viewConfig
    }
    
    public func pokemonViewModel(num: Int) -> PokemonContentViewModel {
        guard let pokemon = _pokemonEntities.first(where: { $0.id == num }) else {
            fatalError("Pokemon not found")
        }
        return PokemonContentViewModel(
            viewConfig: _viewConfig, pokemonEntity: pokemon, isApp: true, isNew: false)
    }
    
    public func pokemonEntity(num: Int) -> PokemonEntity? {
        guard let pokemon = _pokemonEntities.first(where: { $0.id == num }) else {
            return nil
        }
        return pokemon
    }
    
    public var canLoadMore: Bool {
        data.count < _viewConfig.amount
    }
    
    public func loadMore() {
        for i in data.count+1..<data.count+10 {
            data.append(LibraryContentCellViewModel(
                id: i, entity: pokemonEntity(num: i), viewConfig: _viewConfig))
        }
    }
    
    public func isExist(num: Int) -> Bool {
        guard _pokemonEntities.firstIndex(where: { $0.id == num }) != nil else {
            return false
        }
        return true
    }
}
