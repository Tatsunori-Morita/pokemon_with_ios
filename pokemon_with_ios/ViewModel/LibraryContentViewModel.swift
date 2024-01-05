//
//  LibraryContentViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/26.
//

import SwiftUI

class LibraryContentViewModel: ObservableObject {
    @Published
    private(set) var cellViewModels: [LibraryContentCellViewModel] = []
    
    private let _systemConfig: SystemConfig
    private let _pokemonEntities: [PokemonEntity]
    private let _initialNumberOfPokemon = 21
    private let _additionalNumberOfPokemon = 11
    
    init(systemConfig: SystemConfig, pokemonEntities: [PokemonEntity]) {
        _systemConfig = systemConfig
        _pokemonEntities = pokemonEntities
        
        for i in 1..<_initialNumberOfPokemon {
            cellViewModels.append(LibraryContentCellViewModel(
                id: i,
                entity: getPokemonEntity(idValue: try! PokemonEntity.IdValue(id: i)),
                systemConfig: _systemConfig)
            )
        }
    }
    
    public var systemConfig: SystemConfig {
        _systemConfig
    }

    public func getPokemonEntity(idValue: PokemonEntity.IdValue) -> PokemonEntity? {
        guard let pokemon = _pokemonEntities.first(where: { $0.id == idValue.id }) else {
            return nil
        }
        return pokemon
    }
    
    public var canLoadMore: Bool {
        cellViewModels.count < _systemConfig.getAmount
    }
    
    private var nextNumberOfPokemon: Int {
        cellViewModels.count + 1
    }
    
    public var maxNumberOfPokemon: Int {
        cellViewModels.count + _additionalNumberOfPokemon
    }
    
    public func loadMore() {
        for i in nextNumberOfPokemon..<maxNumberOfPokemon {
            cellViewModels.append(LibraryContentCellViewModel(
                id: i,
                entity: getPokemonEntity(idValue: try! PokemonEntity.IdValue(id: i)),
                systemConfig: _systemConfig)
            )
        }
    }
    
    func getNaviFont(size: CGFloat) -> UIFont {
        if _systemConfig.getLanguageMode == .ja {
            return UIFont(name: "HiraginoSans-W6", size: size)!
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    func getFont(size: CGFloat) -> Font {
        _systemConfig.getLanguageMode == .ja ? Font.custom("HiraginoSans-W3", size: size) : Font.system(size: size)
    }
}
