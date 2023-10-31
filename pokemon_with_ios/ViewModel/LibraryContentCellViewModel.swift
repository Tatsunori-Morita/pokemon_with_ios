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
    private let _entity: PokemonEntity?
    private let _systemConfig: SystemConfig
    private let _frontDefault = DomainConfig().frontDefault
    
    public var no: String {
        "No." + String(format: "%04d", _id)
    }
    
    public var name: String {
        guard
            let entity = _entity,
            let name = entity.names.first(where: { $0.language == _systemConfig.getLanguage })
        else {
            return "????"
        }
        return name.name
    }
    
    public var url: String {
        guard let entity = _entity else {
            return String(format: _frontDefault, _id.description)
        }
        return entity.frontDefault
    }
    
    public var isExist: Bool {
        _entity == nil ? false : true
    }
    
    public var opacity: Double {
        if isExist { return 0 }
        if _systemConfig.getColorScheme == .dark { return 0.9 }
        return 0.8
    }
    
    public var entity: PokemonEntity? {
        guard let value = _entity else { return nil }
        return value.createInstance()
    }
    
    init(id: Int, entity: PokemonEntity?, systemConfig: SystemConfig) {
        _id = id
        _entity = entity
        _systemConfig = systemConfig
    }
}
