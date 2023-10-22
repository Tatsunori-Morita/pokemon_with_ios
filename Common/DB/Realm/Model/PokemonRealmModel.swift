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
    @Persisted var pokemonTypes: List<PokemonTypeRealmModel>
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

class PokemonTypeRealmModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var no: Int = 0
    @Persisted var name: String
    @Persisted var language: String = ""
    
    convenience init(idValue: PokemonEntity.IdValue, pokemonTypeValue: PokemonEntity.PokemonTypeValue) {
        self.init()
        self.no = idValue.id
        self.name = pokemonTypeValue.name
        self.language = pokemonTypeValue.language
    }
}
