//
//  LibraryContentViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/26.
//

import Foundation

class LibraryContentViewModel: ObservableObject {
    @Published
    private(set) var cellViewModels: [LibraryContentCellViewModel] = []
    
    private let _viewConfig: ViewConfig
    private let _pokemonEntities: [PokemonEntity]
    
    init(viewConfig: ViewConfig, pokemonEntities: [PokemonEntity]) {
        _viewConfig = viewConfig
        _pokemonEntities = pokemonEntities
        
        for i in 1..<21 {
            cellViewModels.append(LibraryContentCellViewModel(
                id: i,
                entity: getPokemonEntity(num: i),
                viewConfig: _viewConfig)
            )
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
            viewConfig: _viewConfig,
            pokemonEntity: pokemon,
            isApp: true,
            isNew: false)
    }
    
    public func getPokemonEntity(num: Int) -> PokemonEntity? {
        guard let pokemon = _pokemonEntities.first(where: { $0.id == num }) else {
            return nil
        }
        return pokemon
    }
    
    public var canLoadMore: Bool {
        cellViewModels.count < _viewConfig.amount
    }
    
    public func loadMore() {
        for i in cellViewModels.count + 1..<cellViewModels.count + 11 {
            cellViewModels.append(LibraryContentCellViewModel(
                id: i,
                entity: getPokemonEntity(num: i),
                viewConfig: _viewConfig)
            )
        }
    }
    
    public func isExist(num: Int) -> Bool {
        guard _pokemonEntities.firstIndex(where: { $0.id == num }) != nil else {
            return false
        }
        return true
    }
}
