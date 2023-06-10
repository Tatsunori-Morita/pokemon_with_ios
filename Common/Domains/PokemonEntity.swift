//
//  PokemonDomain.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/05/15.
//

import Foundation
import SwiftUI

class PokemonEntity {
    private let _idValue: IdValue
    private let _nameValues: [NameValue]
    private let _weightValue: WeightValue
    private let _heightValue: HeightValue
    private let _generaValues: [GenusValue]
    private let _flavorTextEntryValues: [FlavorTextEntryValue]
    private let _frontDefaultValue: FrontDefaultValue
    private let _pokemonTypeValues: [PokemonTypeValue]

    public var id: Int {
        _idValue.id
    }

    public var idValue: IdValue {
        _idValue
    }

    public var formatedId: String {
        _idValue.formatedId
    }

    public var names: [NameValue] {
        _nameValues
    }

    public var weight: Int {
        _weightValue.weight
    }

    public var height: Int {
        _heightValue.height
    }

    public var genera: [GenusValue] {
        _generaValues
    }

    public var flavorTextEntries: [FlavorTextEntryValue] {
        _flavorTextEntryValues
    }

    public var frontDefault: String {
        _frontDefaultValue.frontDefault
    }
    
    public var pokemonTypeValues: [PokemonTypeValue] {
        _pokemonTypeValues
    }

    init(id: IdValue, names: [NameValue], weight: WeightValue, height: HeightValue, genera: [GenusValue], flavorTextEntries: [FlavorTextEntryValue], frontDefault: FrontDefaultValue, pokemonTypeValues: [PokemonTypeValue]) {
        _idValue = id
        _nameValues = names
        _weightValue = weight
        _heightValue = height
        _generaValues = genera
        _flavorTextEntryValues = flavorTextEntries
        _frontDefaultValue = frontDefault
        _pokemonTypeValues = pokemonTypeValues
    }

    class IdValue {
        private let _id: Int

        public var id: Int {
            _id
        }

        public var formatedId: String {
            return String(format: "%03d", self.id)
        }

        init(id: Int) {
            if id < 1 {
                fatalError("IDが0以下の値が設定されています")
            }
            _id = id
        }
    }

    class LanguageValue {
        private let _language: String

        public var language: String {
            _language
        }

        init(language: String) {
            if (language.isEmpty) {
                fatalError("言語が設定されていません")
            }
            _language = language
        }
    }

    class NameValue {
        private let _name: String
        private let _language: LanguageValue

        public var name: String {
            _name
        }

        public var language: String {
            _language.language
        }

        init(name: String, language: LanguageValue) {
            if (name.isEmpty) {
                fatalError("名前が設定されていません")
            }
            _name = name
            _language = language
        }
    }

    class HeightValue {
        private let _height: Int

        public var height: Int {
            _height
        }

        init(height: Int) {
            if height < 0 {
                fatalError("高さが0以下の値が設定されています")
            }
            _height = height
        }
    }

    class WeightValue {
        private let _weight: Int

        public var weight: Int {
            _weight
        }

        init(weight: Int) {
            if weight < 0 {
                fatalError("重さが0以下の値が設定されています")
            }
            _weight = weight
        }
    }

    class GenusValue {
        private let _genus: String
        private let _language: LanguageValue

        public var genus: String {
            _genus
        }

        public var language: String {
            _language.language
        }

        init(genus: String, language: LanguageValue) {
            if genus.isEmpty {
                fatalError("ジャンルが設定されていません")
            }
            _genus = genus
            _language = language
        }
    }

    class FlavorTextEntryValue {
        private let _flavorTextEntry: String
        private let _language: LanguageValue

        public var flavorTextEntry: String {
            _flavorTextEntry
        }

        public var language: String {
            _language.language
        }

        init(flavorTextEntry: String, language: LanguageValue) {
            if flavorTextEntry.isEmpty {
                fatalError("説明分が設定されていません")
            }
            _flavorTextEntry = flavorTextEntry
            _language = language
        }
    }

    /// アートワーク画像
    class FrontDefaultValue {
        private let _frontDefault: String

        public var frontDefault: String {
            _frontDefault
        }

        init(frontDefault: String) {
            _frontDefault = frontDefault
        }
    }
    
    class PokemonTypeValue {
        private let _name: String
        private let _language: LanguageValue
        
        enum Types {
            case Normal
            case Fire
            case Water
            case Grass
            case Electric
            case Ice
            case Fighting
            case Poison
            case Ground
            case Flying
            case Psychic
            case Bug
            case Rock
            case Ghost
            case Dragon
            case Dark
            case Steel
            case Fairy
        }
        
        public var name: String {
            _name
        }

        public var typeJapanese: Types  {
            switch _name {
            case "ノーマル":
                return .Normal
            case "ほのお":
                return .Fire
            case "みず":
                return .Water
            case "くさ":
                return .Grass
            case "でんき":
                return .Electric
            case "こおり":
                return .Ice
            case "かくとう":
                return .Fighting
            case "どく":
                return .Poison
            case "じめん":
                return .Ground
            case "ひこう":
                return .Flying
            case "エスパー":
                return .Psychic
            case "むし":
                return .Bug
            case "いわ":
                return .Rock
            case "ゴースト":
                return .Ghost
            case "ドラゴン":
                return .Dragon
            case "あく":
                return .Dark
            case "はがね":
                return .Steel
            case "フェアリー":
                return .Fairy
            default:
                fatalError("対象の日本語属性が存在しません")
            }
        }
        
        public var typeEnglish: Types  {
            switch _name {
            case "Normal":
                return .Normal
            case "Fire":
                return .Fire
            case "Water":
                return .Water
            case "Grass":
                return .Grass
            case "Electric":
                return .Electric
            case "Ice":
                return .Ice
            case "Fighting":
                return .Fighting
            case "Poison":
                return .Poison
            case "Ground":
                return .Ground
            case "Flying":
                return .Flying
            case "Psychic":
                return .Psychic
            case "Bug":
                return .Bug
            case "Rock":
                return .Rock
            case "Ghost":
                return .Ghost
            case "Dragon":
                return .Dragon
            case "Dark":
                return .Dark
            case "Steel":
                return .Steel
            case "Fairy":
                return .Fairy
            default:
                fatalError("対象の英語語属性が存在しません")
            }
        }
        
        public var color: Color {
            let type = _language.language == "ja" ? typeJapanese : typeEnglish
            switch type {
            case .Normal:
                return .normal
            case .Fire:
                return .fire
            case .Water:
                return .water
            case .Grass:
                return .grass
            case .Electric:
                return .electric
            case .Ice:
                return .ice
            case .Fighting:
                return .flying
            case .Poison:
                return .poison
            case .Ground:
                return .ground
            case .Flying:
                return .flying
            case .Psychic:
                return .psychic
            case .Bug:
                return .bug
            case .Rock:
                return .rock
            case .Ghost:
                return .ghost
            case .Dragon:
                return .dragon
            case .Dark:
                return .dark
            case .Steel:
                return .steel
            case .Fairy:
                return .fairy
            }
        }
        
        public var language: String {
            _language.language
        }
        
        init(name: String, language: LanguageValue) {
            if name.isEmpty {
                fatalError("タイプが設定されていません")
            }
            _name = name
            _language = language
        }
    }
}
