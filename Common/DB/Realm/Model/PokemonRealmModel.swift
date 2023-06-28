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

    convenience init(entity: PokemonEntity) {
        self.init()
        self.no = entity.id
        entity.names.forEach { name in
            if name.language == "ja" || name.language == "en" {
                self.names.append(NameRealmModel(idValue: entity.idValue, nameValue: name))
            }
        }
        self.weight = entity.weight
        self.height = entity.height
        entity.genera.forEach { genus in
            if genus.language == "ja" || genus.language == "en" {
                self.genera.append(GenusRealmModel(idValue: entity.idValue, genusValue: genus))
            }
        }
        
        // 各言語でバージョンによって複数存在するため、最初の１件だけ取得
        if let jaText = entity.flavorTextEntries.filter({ $0.language == "ja" }).first {
            self.flavorTextEntries.append(FlavorTextEntryRealmModel(idValue: entity.idValue, flavorTextEntryValue: jaText))
        }
        
        if let enText = entity.flavorTextEntries.filter({ $0.language == "en" }).first {
            self.flavorTextEntries.append(FlavorTextEntryRealmModel(idValue: entity.idValue, flavorTextEntryValue: enText))
        }
        
        self.frontDefault = entity.frontDefault
        self.officialArtwork = OfficialArtworkRealmModel(entity: entity)
        entity.pokemonTypeValues.forEach { pokemonType in
            if pokemonType.language == "ja" || pokemonType.language == "en" {
                self.pokemonTypes.append(PokemonTypeRealmModel(idValue: entity.idValue, pokemonTypeValue: pokemonType))
            }
        }
    }

    public func createPokemonEntity() -> PokemonEntity {
        let id = PokemonEntity.IdValue(id: self.no)
        let names = names.map { PokemonEntity.NameValue(name: $0.name, language: PokemonEntity.LanguageValue(language: $0.language)) }
        let weight = PokemonEntity.WeightValue(weight: weight)
        let height = PokemonEntity.HeightValue(height: height)
        let genera = genera.map { PokemonEntity.GenusValue(genus: $0.genus, language: PokemonEntity.LanguageValue(language: $0.language))}
        let flavorTextEntries = flavorTextEntries.map { PokemonEntity.FlavorTextEntryValue(flavorTextEntry: $0.flavorText, language: PokemonEntity.LanguageValue(language: $0.language)) }
        let frontDefault = PokemonEntity.FrontDefaultValue(frontDefault: frontDefault)
        let types = pokemonTypes.map { PokemonEntity.PokemonTypeValue(name: $0.name, language: PokemonEntity.LanguageValue(language: $0.language))}
        let entity = PokemonEntity(id: id, names: Array(names), weight: weight, height: height, genera: Array(genera), flavorTextEntries: Array(flavorTextEntries), frontDefault: frontDefault, pokemonTypeValues: Array(types))
        return entity
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
