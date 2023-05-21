//
//  RealmRepository.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/05/01.
//

import RealmSwift
import Foundation

class RealmRepository: IRepository {
    private let _realm: Realm

    init() {
        var config = Realm.Configuration()
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.tatsunori.morita.pokemon-with-ios")!
        config.fileURL = url.appendingPathComponent("db.realm")
        _realm = try! Realm(configuration: config)
        print()
    }

    public func add(entity: PokemonEntity) {
        let model = PokemonRealmModel(entity: entity)
        try! _realm.write {
            _realm.add(model)
        }
    }

    func getEntityBy(no: PokemonEntity.IdValue) -> PokemonEntity? {
        let result = _realm.objects(PokemonRealmModel.self).filter("%K == %d", "no", no.id)
        if result.isEmpty {
            return nil
        }
        return result.first!.createPokemonEntity()
    }

    func select() -> [PokemonEntity] {
        let result = _realm.objects(PokemonRealmModel.self).sorted(byKeyPath: "no", ascending: true)
        return Array(result.map { $0.createPokemonEntity() })
    }

    func delete(entity: PokemonEntity) {
        let model = PokemonRealmModel(entity: entity)
        try! _realm.write {
            _realm.delete(model)
        }
    }

    public func print() {
        Swift.print("Realm is located at: \(_realm.configuration.fileURL!)")
    }
}
