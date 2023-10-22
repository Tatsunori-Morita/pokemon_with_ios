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
        let model = PokemonRealmFactory.createModel(entity: entity)
        try! _realm.write {
            _realm.add(model)
        }
    }

    func getEntityBy(no: PokemonEntity.IdValue) -> PokemonEntity? {
        guard let model = _getRealmModelBy(no: no) else {
            return nil
        }
        return PokemonRealmFactory.createEntity(model: model)
    }

    private func _getRealmModelBy(no: PokemonEntity.IdValue) -> PokemonRealmModel? {
        let result = _realm.objects(PokemonRealmModel.self).filter("%K == %d", "no", no.id)
        if result.isEmpty {
            return nil
        }
        return result.first!
    }
    
    func select() -> [PokemonEntity] {
        let result = _realm.objects(PokemonRealmModel.self).sorted(byKeyPath: "no", ascending: true)
        return Array(result.map { PokemonRealmFactory.createEntity(model: $0) })
    }

    func delete(entity: PokemonEntity) {
        if let model = _getRealmModelBy(no: entity.idValue) {
            try! _realm.write {
                _realm.delete(model)
            }
        }
    }

    public func print() {
        Swift.print("Realm is located at: \(_realm.configuration.fileURL!)")
    }
}
