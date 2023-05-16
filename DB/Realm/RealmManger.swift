//
//  RealmManger.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/05/01.
//

import RealmSwift
import Foundation

final class RealmManger {
    public static let shared = RealmManger()
    private let realm: Realm

    init() {
        var config = Realm.Configuration()
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.tatsunori.morita.pokemon-with-ios")!
        config.fileURL = url.appendingPathComponent("db.realm")
        realm = try! Realm(configuration: config)
    }

    public func add(entity: PokemonEntity) {
        let dataObject = PokemonRealmDataObject(entity: entity)
        try! RealmManger.shared.realm.write {
            RealmManger.shared.realm.add(dataObject)
        }
    }

    public func print() {
        Swift.print("Realm is located at: \(RealmManger.shared.realm.configuration.fileURL!)")
    }
}
