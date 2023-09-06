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
        
        for i in 1..<_viewConfig.initialNumberOfPokemon {
            cellViewModels.append(LibraryContentCellViewModel(
                id: i,
                entity: getPokemonEntity(idValue: try! PokemonEntity.IdValue(id: i)),
                viewConfig: _viewConfig)
            )
        }
    }
    
    public var viewConfig: ViewConfig {
        _viewConfig
    }

    public func getPokemonEntity(idValue: PokemonEntity.IdValue) -> PokemonEntity? {
        guard let pokemon = _pokemonEntities.first(where: { $0.id == idValue.id }) else {
            return nil
        }
        return pokemon
    }
    
    public var canLoadMore: Bool {
        cellViewModels.count < _viewConfig.amount
    }
    
    private var nextNumberOfPokemon: Int {
        cellViewModels.count + 1
    }
    
    public var maxNumberOfPokemon: Int {
        cellViewModels.count + _viewConfig.additionalNumberOfPokemon
    }
    
    public func loadMore() {
        for i in nextNumberOfPokemon..<maxNumberOfPokemon {
            cellViewModels.append(LibraryContentCellViewModel(
                id: i,
                entity: getPokemonEntity(idValue: try! PokemonEntity.IdValue(id: i)),
                viewConfig: _viewConfig)
            )
        }
    }
}
