//
//  PokemonContentViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/02.
//

import Foundation
import SwiftUI

struct PokemonContentViewModel {
    private let _viewConfig: ViewConfig
    private let _pokemonEntity: PokemonEntity
    private let _isApp: Bool

    init(viewConfig: ViewConfig, pokemonEntity: PokemonEntity, isApp: Bool) {
        _viewConfig = viewConfig
        _pokemonEntity = pokemonEntity
        _isApp = isApp
    }
    
    public var isApp: Bool {
        _isApp
    }

    public var id: String {
        "No." + String(format: "%04d", _pokemonEntity.id)
    }

    public var name: String {
        guard
            let name = _pokemonEntity.names.filter({ $0.language == _viewConfig.language }).first
        else {
            return ""
        }
        return name.name
    }

    public var genera: String {
        guard
            let genus = _pokemonEntity.genera.filter({ $0.language == _viewConfig.language }).first
        else {
            return "未確認"
        }
        return genus.genus
    }

    public var height: String {
        let value = Double(_pokemonEntity.height) / 10
        return String(format: "%.1f", value) + "m"
    }

    public var weight: String {
        let value = Double(_pokemonEntity.weight) / 10
        return String(format: "%.1f", value) + "Kg"
    }

    public var types: [PokemonEntity.PokemonTypeValue] {
        var array: [PokemonEntity.PokemonTypeValue] = []
        _pokemonEntity.pokemonTypeValues.forEach { pokemonType in
            if pokemonType.language == _viewConfig.language {
                array.append(pokemonType)
            }
        }
        return array
    }
    
    public var flavorTextEntry: String {
        guard
            let flavorTextEntry = _pokemonEntity.flavorTextEntries.filter({ $0.language == _viewConfig.language }).last
        else {
            return "未確認"
        }
        return flavorTextEntry.flavorTextEntry.replacingOccurrences(of: "\n", with: "")
    }

    public var image: Image {
        guard let url = URL(string: _pokemonEntity.frontDefault),
              let imageData = try? Data(contentsOf: url),
              let image = UIImage(data: imageData)
        else {
            return Image(uiImage: UIImage())
        }

        return Image(uiImage: image)
    }
    
    public func typeName(index: Int) -> String {
        let types = self.types
        return types[index].name
    }
    
    public func typeColor(index: Int) -> Color {
        let types = self.types
        return types[index].color
    }
}
