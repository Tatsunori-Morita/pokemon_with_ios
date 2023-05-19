//
//  PokemonDomain.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/05/15.
//

import Foundation

class PokemonEntity {
    private let _idValue: IdValue
    private let _nameValue: NameValue
    private let _weightValue: WeightValue
    private let _heightValue: HeightValue
    private let _generaValue: GeneraValue
    private let _flavorTextEntryValue: FlavorTextEntryValue
    private let _frontDefaultValue: FrontDefaultValue

    public var id: Int {
        _idValue.id
    }

    public var formatedId: String {
        _idValue.formatedId
    }

    public var name: String {
        _nameValue.name
    }

    public var weight: Int {
        _weightValue.weight
    }

    public var height: Int {
        _heightValue.height
    }

    public var genera: String {
        _generaValue.genera
    }

    public var flavorTextEntry: String {
        _flavorTextEntryValue.flavorTextEntry
    }

    public var frontDefault: String {
        _frontDefaultValue.frontDefault
    }

    init(id: IdValue, name: NameValue, weight: WeightValue, height: HeightValue, genera: GeneraValue, flavorTextEntry: FlavorTextEntryValue, frontDefault: FrontDefaultValue) {
        _idValue = id
        _nameValue = name
        _weightValue = weight
        _heightValue = height
        _generaValue = genera
        _flavorTextEntryValue = flavorTextEntry
        _frontDefaultValue = frontDefault
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
            if id < 0 {
                fatalError("IDが0以下の値が設定されています")
            }
            _id = id
        }
    }

    class NameValue {
        private let _name: String

        public var name: String {
            _name
        }

        init(name: String) {
            if (name.isEmpty) {
                fatalError("名前が設定されていません")
            }
            _name = name
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

    class GeneraValue {
        private let _genera: String

        public var genera: String {
            _genera
        }

        init(genera: String) {
            if genera.isEmpty {
                fatalError("ジャンルが設定されていません")
            }
            _genera = genera
        }
    }

    class FlavorTextEntryValue {
        private let _flavorTextEntry: String

        public var flavorTextEntry: String {
            _flavorTextEntry
        }

        init(flavorTextEntry: String) {
            if flavorTextEntry.isEmpty {
                fatalError("説明分が設定されていません")
            }
            _flavorTextEntry = flavorTextEntry
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
}
