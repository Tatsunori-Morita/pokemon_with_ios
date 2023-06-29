//
//  LibraryContentCellViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/29.
//

import Foundation

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
