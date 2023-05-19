//
//  RealmManger.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/05/01.
//

import RealmSwift
import Foundation

class RealmManger: IRepository {
    private let _realm: Realm

    init() {
        var config = Realm.Configuration()
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.tatsunori.morita.pokemon-with-ios")!
        config.fileURL = url.appendingPathComponent("db.realm")
        _realm = try! Realm(configuration: config)
    }

    public func add(entity: PokemonEntity) {
        let dataObject = PokemonRealmDataObject(entity: entity)
        try! _realm.write {
            _realm.add(dataObject)
        }
    }

    public func print() {
        Swift.print("Realm is located at: \(_realm.configuration.fileURL!)")
    }
}
