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

        init(id: Int) throws {
            if id < 1 {
                throw NSError(domain: "IDが0以下の値が設定されています", code: -1)
            }
            _id = id
        }
    }

    class LanguageValue {
        private let _language: String

        public var language: String {
            _language
        }

        init(language: String) throws {
            if (language.isEmpty) {
                throw NSError(domain: "言語が設定されていません", code: -1)
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

        init(name: String, language: LanguageValue) throws {
            if (name.isEmpty) {
                throw NSError(domain: "名前が設定されていません", code: -1)
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

        init(height: Int) throws {
            if height < 1 {
                throw NSError(domain: "高さが0以下の値が設定されています", code: -1)
            }
            _height = height
        }
    }

    class WeightValue {
        private let _weight: Int

        public var weight: Int {
            _weight
        }

        init(weight: Int) throws {
            if weight < 1 {
                throw NSError(domain: "重さが0以下の値が設定されています", code: -1)
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

        init(genus: String, language: LanguageValue) throws {
            if genus.isEmpty {
                throw NSError(domain: "ジャンルが設定されていません", code: -1)
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

        init(flavorTextEntry: String, language: LanguageValue) throws {
            if flavorTextEntry.isEmpty {
                throw NSError(domain: "説明文が設定されていません", code: -1)
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

        init(frontDefault: String) throws {
            if frontDefault.isEmpty {
                throw NSError(domain: "アートワーク画像が設定されていません", code: -1)
            }
            _frontDefault = frontDefault
        }
    }
    
    class PokemonTypeValue: Identifiable {
        let id = UUID()
        private let _name: String
        private let _language: LanguageValue
        private let _typeValues: [TypeValue] = [
            try! TypeValue(jaName: "ノーマル", enName: "Normal", color: Color.normal),
            try! TypeValue(jaName: "ほのお", enName: "Fire", color: Color.fire),
            try! TypeValue(jaName: "みず", enName: "Water", color: Color.water),
            try! TypeValue(jaName: "くさ", enName: "Grass", color: Color.grass),
            try! TypeValue(jaName: "でんき", enName: "Electric", color: Color.electric),
            try! TypeValue(jaName: "こおり", enName: "Ice", color: Color.ice),
            try! TypeValue(jaName: "かくとう", enName: "Fighting", color: Color.fighting),
            try! TypeValue(jaName: "どく", enName: "Poison", color: Color.poison),
            try! TypeValue(jaName: "じめん", enName: "Ground", color: Color.ground),
            try! TypeValue(jaName: "ひこう", enName: "Flying", color: Color.flying),
            try! TypeValue(jaName: "エスパー", enName: "Psychic", color: Color.psychic),
            try! TypeValue(jaName: "むし", enName: "Bug", color: Color.bug),
            try! TypeValue(jaName: "いわ", enName: "Rock", color: Color.rock),
            try! TypeValue(jaName: "ゴースト", enName: "Ghost", color: Color.ghost),
            try! TypeValue(jaName: "ドラゴン", enName: "Dragon", color: Color.dragon),
            try! TypeValue(jaName: "あく", enName: "Dark", color: Color.dark),
            try! TypeValue(jaName: "はがね", enName: "Steel", color: Color.steel),
            try! TypeValue(jaName: "フェアリー", enName: "Fairy", color: Color.fairy),
        ]
        
        public var name: String {
            _name
        }

        public var language: String {
            _language.language
        }
        
        public var typeValue: TypeValue {
            if let value = _typeValues.first(where: { $0.jaName == _name || $0.enName == _name}) {
                return value
            }
            fatalError("対象のタイプが存在しません")
        }
        
        init(name: String, language: LanguageValue) throws {
            if name.isEmpty {
                throw NSError(domain: "タイプが設定されていません", code: -1)
            }
            _name = name
            _language = language
        }
        
        struct TypeValue {
            private let _jaName: String
            private let _enName: String
            private let _color: Color
            
            public var jaName: String {
                _jaName
            }
            
            public var enName: String {
                _enName
            }
            
            public var color: Color {
                _color
            }
            
            init(jaName: String, enName: String, color: Color) throws {
                if jaName.isEmpty {
                    throw NSError(domain: "日本語のタイプ名が設定されていません", code: -1)
                }
                
                if enName.isEmpty {
                    throw NSError(domain: "英語のタイプ名が設定されていません", code: -1)
                }
                
                _jaName = jaName
                _enName = enName
                _color = color
            }
        }
    }
}
