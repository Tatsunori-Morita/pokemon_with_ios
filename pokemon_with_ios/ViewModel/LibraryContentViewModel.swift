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
    
    public let _pokemons: [PokemonEntity]
    
    private let max = 1010
    
    init() {
        _pokemons = RealmRepository().select().map({$0})
        
        for i in 1..<21 {
            data.append(LibraryContentCellViewModel(id: i, entity: pokemonEntity(num: i)))
        }
    }
    
    public func pokemonViewModel(num: Int) -> WidgetContentViewModel {
        guard let pokemon = _pokemons.first(where: { $0.id == num }) else {
            fatalError("Pokemon not found")
        }
        return WidgetContentViewModel(pokemonEntity: pokemon, isApp: true)
    }
    
    public func pokemonEntity(num: Int) -> PokemonEntity? {
        guard let pokemon = _pokemons.first(where: { $0.id == num }) else {
            return nil
        }
        return pokemon
    }
    
    public var canLoadMore: Bool {
        data.count < max
    }
    
    public func loadMore() {
        for i in data.count+1..<data.count+10 {
            data.append(LibraryContentCellViewModel(id: i, entity: pokemonEntity(num: i)))
        }
    }
    
    public func isExist(num: Int) -> Bool {
        guard _pokemons.firstIndex(where: { $0.id == num }) != nil else {
            return false
        }
        return true
    }
}

struct LibraryContentCellViewModel: Identifiable {    
    var id = UUID()
    private let _id: Int
    let _entity: PokemonEntity?
    
    public var no: String {
        "No." + String(format: "%04d", _id)
    }
    
    public var name: String {
        guard let entity = _entity else {
            return "????"
        }
        return entity.names.last!.name
    }
    
    public var url: String {
        guard let entity = _entity else {
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(_id).png"
        }
        return entity.frontDefault
    }
    
    public var isExist: Bool {
        _entity == nil ? false : true
    }
    
    init(id: Int, entity: PokemonEntity?) {
        _id = id
        _entity = entity
    }
}
