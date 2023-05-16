//
//  TestModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/05/01.
//

import RealmSwift

class PokemonRealmDataObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var no: Int = 0
    @Persisted var name: String = ""
    @Persisted var weight: Int = 0
    @Persisted var height: Int = 0
    @Persisted var genera: String = ""
    @Persisted var flavorTextEntry: String = ""
    @Persisted var frontDefault: String = ""

    convenience init(entity: PokemonEntity) {
        self.init()
        self.no = entity.id
        self.name = entity.name
        self.weight = entity.weight
        self.height = entity.height
        self.genera = entity.genera
        self.flavorTextEntry = entity.flavorTextEntry
        self.frontDefault = entity.frontDefault
    }
}
