//
//  PokemonRealmFactory.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/09/15.
//

struct PokemonRealmFactory {
    public static func createEntity(model: PokemonRealmModel) -> PokemonEntity {
        do {
            let id = try PokemonEntity.IdValue(id: model.no)
            let names = try model.names.map { try PokemonEntity.NameValue(name: $0.name, language: try PokemonEntity.LanguageValue(language: $0.language)) }
            let weight = try PokemonEntity.WeightValue(weight: model.weight)
            let height = try PokemonEntity.HeightValue(height: model.height)
            let genera = try model.genera.map { try PokemonEntity.GenusValue(genus: $0.genus, language: try PokemonEntity.LanguageValue(language: $0.language))}
            let flavorTextEntries = try model.flavorTextEntries.map { try PokemonEntity.FlavorTextEntryValue(flavorTextEntry: $0.flavorText, language: try PokemonEntity.LanguageValue(language: $0.language)) }
            let frontDefault = try PokemonEntity.FrontDefaultValue(frontDefault: model.frontDefault)
            let types = try model.pokemonTypes.map { try PokemonEntity.PokemonTypeValue(name: $0.name, language: try PokemonEntity.LanguageValue(language: $0.language))}
            let entity = PokemonEntity(id: id, names: Array(names), weight: weight, height: height, genera: Array(genera), flavorTextEntries: Array(flavorTextEntries), frontDefault: frontDefault, pokemonTypeValues: Array(types))
            return entity
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public static func createModel(entity: PokemonEntity) -> PokemonRealmModel {
        let model = PokemonRealmModel()
        model.no = entity.id
        entity.names.forEach { name in
            if name.language == "ja" || name.language == "en" {
                model.names.append(NameRealmModel(idValue: entity.idValue, nameValue: name))
            }
        }
        model.weight = entity.weight
        model.height = entity.height
        entity.genera.forEach { genus in
            if genus.language == "ja" || genus.language == "en" {
                model.genera.append(GenusRealmModel(idValue: entity.idValue, genusValue: genus))
            }
        }
        
        // 各言語でバージョンによって複数存在するため、最初の１件だけ取得
        if let jaText = entity.flavorTextEntries.filter({ $0.language == "ja" }).first {
            model.flavorTextEntries.append(FlavorTextEntryRealmModel(idValue: entity.idValue, flavorTextEntryValue: jaText))
        }
        
        if let enText = entity.flavorTextEntries.filter({ $0.language == "en" }).first {
            model.flavorTextEntries.append(FlavorTextEntryRealmModel(idValue: entity.idValue, flavorTextEntryValue: enText))
        }
        
        model.frontDefault = entity.frontDefault
        model.officialArtwork = OfficialArtworkRealmModel(entity: entity)
        entity.pokemonTypeValues.forEach { pokemonType in
            if pokemonType.language == "ja" || pokemonType.language == "en" {
                model.pokemonTypes.append(PokemonTypeRealmModel(idValue: entity.idValue, pokemonTypeValue: pokemonType))
            }
        }
        return model
    }
}
