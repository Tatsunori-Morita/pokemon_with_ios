//
//  LibraryContentCellViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/29.
//

import Foundation

struct LibraryContentCellViewModel: Identifiable {
    let id = UUID()
    private let _id: Int
    let _entity: PokemonEntity?
    private let _viewConfig: ViewConfig
    
    public var no: String {
        "No." + String(format: "%04d", _id)
    }
    
    public var name: String {
        guard
            let entity = _entity,
            let name = entity.names.first(where: { $0.language == _viewConfig.language })
        else {
            return "????"
        }
        return name.name
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
    
    public var opacity: Double {
        if isExist { return 0 }
        if _viewConfig.isDarkMode { return 0.9 }
        return 0.8
    }
    
    init(id: Int, entity: PokemonEntity?, viewConfig: ViewConfig) {
        _id = id
        _entity = entity
        _viewConfig = viewConfig
    }
}
