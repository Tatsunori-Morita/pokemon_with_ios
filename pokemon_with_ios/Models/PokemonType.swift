//
//  PokemonType.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/22.
//

import Foundation

struct PokemonType: Codable {
    let damageRelations: DamageRelations?
    let gameIndices: [GameIndex]?
    let generation: Generation?
    let id: Int?
    let moveDamageClass: Generation?
    let moves: [Generation]?
    let name: String?
    let names: [Name]?
//    let pastDamageRelations: [JSONAny]
    let pokemon: [Pokemon]?

    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
        case gameIndices = "game_indices"
        case generation, id
        case moveDamageClass = "move_damage_class"
        case moves, name, names
//        case pastDamageRelations = "past_damage_relations"
        case pokemon
    }
}

// MARK: - DamageRelations
struct DamageRelations: Codable {
    let doubleDamageFrom, doubleDamageTo, halfDamageFrom, halfDamageTo: [Generation]?
//    let noDamageFrom: [JSONAny]
    let noDamageTo: [Generation]?

    enum CodingKeys: String, CodingKey {
        case doubleDamageFrom = "double_damage_from"
        case doubleDamageTo = "double_damage_to"
        case halfDamageFrom = "half_damage_from"
        case halfDamageTo = "half_damage_to"
//        case noDamageFrom = "no_damage_from"
        case noDamageTo = "no_damage_to"
    }
}

// MARK: - Generation
struct Generation: Codable {
    let name: String?
    let url: String?
}

//// MARK: - GameIndex
//struct GameIndex: Codable {
//    let gameIndex: Int
//    let generation: Generation
//
//    enum CodingKeys: String, CodingKey {
//        case gameIndex = "game_index"
//        case generation
//    }
//}
