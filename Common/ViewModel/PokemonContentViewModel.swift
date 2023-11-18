//
//  PokemonContentViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/06/02.
//

import SwiftUI

protocol IPokemonContentViewModel {
    var isNew: Bool { get }
    var isApp: Bool { get }
    var id: String { get }
    var name: String { get }
    var genera: String { get }
    var height: String { get }
    var weight: String { get }
    var types: [PokemonEntity.PokemonTypeValue] { get }
    var flavorTextEntry: String { get }
    var image: Image { get }
    var frontDefault: String { get }
    var getLanguageMode: String { get }
    var getColorScheme: ColorScheme { get }
    func getFont(size: CGFloat) -> Font
}

class PokemonContentViewModel: IPokemonContentViewModel {
    private let _systemConfig: SystemConfig
    private let _pokemonEntity: PokemonEntity
    private let _isApp: Bool
    private let _isNew: Bool

    init(systemConfig: SystemConfig, pokemonEntity: PokemonEntity, isApp: Bool, isNew: Bool) {
        _systemConfig = systemConfig
        _pokemonEntity = pokemonEntity
        _isApp = isApp
        _isNew = isNew
    }

    public var isNew: Bool {
        _isNew
    }
    
    public var isApp: Bool {
        _isApp
    }

    public var id: String {
        "No." + String(format: "%04d", _pokemonEntity.id)
    }

    public var name: String {
        guard
            let name = _pokemonEntity.names.filter({ $0.language == _systemConfig.getLanguage }).first
        else {
            return ""
        }
        return name.name
    }

    public var genera: String {
        guard
            let genus = _pokemonEntity.genera.filter({ $0.language == _systemConfig.getLanguage }).first
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
        _pokemonEntity.pokemonTypeValues.filter { $0.language == _systemConfig.getLanguage}
    }
    
    public var flavorTextEntry: String {
        guard
            let flavorTextEntry = _pokemonEntity.flavorTextEntries.filter({ $0.language == _systemConfig.getLanguage }).first
        else {
            return "未確認"
        }
        
        if _systemConfig.getLanguage == "ja" {
            return flavorTextEntry.flavorTextEntry.replacingOccurrences(of: "\n", with: " ")
        }
        
        let originFlavorText = flavorTextEntry.flavorTextEntry
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "POKéMON", with: "POKEMON")
        
        let FF_Code: CChar = 12
        var convertedFlavorText = ""
        for code in originFlavorText.unicodeScalars {
            if code.value == FF_Code {
                convertedFlavorText.append(String(" "))
                continue
            }
            convertedFlavorText.append(String(code))
        }
        return convertedFlavorText.replacingOccurrences(of: "POKEMON", with: "POKéMON")
    }

    // Widget can not use AsyncImage.
    public var image: Image {
        guard let url = URL(string: _pokemonEntity.frontDefault),
              let imageData = try? Data(contentsOf: url),
              let image = UIImage(data: imageData)
        else {
            return Image(uiImage: UIImage())
        }
        return Image(uiImage: image)
    }
    
    public var frontDefault: String {
        _pokemonEntity.frontDefault
    }
    
    var getLanguageMode: String {
        _systemConfig.getLanguage
    }
    
    var getColorScheme: ColorScheme {
        if _systemConfig.getColorScheme == .light {
            return .light
        }
        return .dark
    }
    
    func getFont(size: CGFloat) -> Font {
        _systemConfig.getLanguageMode == .ja ? Font.custom("HiraginoSans-W3", size: size) : Font.system(size: size)
    }
}


class PreviewPokemonContentViewModel: PokemonContentViewModel {}
