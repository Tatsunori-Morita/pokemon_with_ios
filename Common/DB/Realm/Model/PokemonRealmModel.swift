//
//  PokemonRealmModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/05/01.
//

import RealmSwift

class PokemonRealmModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var no: Int = 0
    @Persisted var names: List<NameRealmModel>
    @Persisted var weight: Int = 0
    @Persisted var height: Int = 0
    @Persisted var genera: List<GenusRealmModel>
    @Persisted var flavorTextEntries: List<FlavorTextEntryRealmModel>
    @Persisted var frontDefault: String = ""
    @Persisted var officialArtwork: OfficialArtworkRealmModel?

    convenience init(entity: PokemonEntity) {
        self.init()
        self.no = entity.id
        entity.names.forEach { name in
            self.names.append(NameRealmModel(idValue: entity.idValue, nameValue: name))
        }
        self.weight = entity.weight
        self.height = entity.height
        entity.genera.forEach { genus in
            self.genera.append(GenusRealmModel(idValue: entity.idValue, genusValue: genus))
        }
        entity.flavorTextEntries.forEach { flavorTextEntry in
            self.flavorTextEntries.append(FlavorTextEntryRealmModel(idValue: entity.idValue, flavorTextEntryValue: flavorTextEntry))
        }
        self.frontDefault = entity.frontDefault
        self.officialArtwork = OfficialArtworkRealmModel(entity: entity)
    }
}

class NameRealmModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var no: Int = 0
    @Persisted var name: String = ""
    @Persisted var language: String = ""

    convenience init(idValue: PokemonEntity.IdValue, nameValue: PokemonEntity.NameValue) {
        self.init()
        self.no = idValue.id
        self.name = nameValue.name
        self.language = nameValue.language
    }
}

class GenusRealmModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var no: Int = 0
    @Persisted var genus: String = ""
    @Persisted var language: String = ""

    convenience init(idValue: PokemonEntity.IdValue, genusValue: PokemonEntity.GenusValue) {
        self.init()
        self.no = idValue.id
        self.genus = genusValue.genus
        self.language = genusValue.language
    }
}

class FlavorTextEntryRealmModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var no: Int = 0
    @Persisted var flavorText: String = ""
    @Persisted var language: String = ""

    convenience init(idValue: PokemonEntity.IdValue, flavorTextEntryValue: PokemonEntity.FlavorTextEntryValue) {
        self.init()
        self.no = idValue.id
        self.flavorText = flavorTextEntryValue.flavorTextEntry
        self.language = flavorTextEntryValue.language
    }
}

class OfficialArtworkRealmModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var no: Int = 0
    @Persisted var frontDefault: String

    convenience init(entity: PokemonEntity) {
        self.init()
        self.no = entity.id
        self.frontDefault = entity.frontDefault
    }
}
