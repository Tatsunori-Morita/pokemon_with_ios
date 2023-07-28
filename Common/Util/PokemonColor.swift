//
//  PokemonColor.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/07/26.
//

import SwiftUI

struct PokemonColor {
    static let shared = PokemonColor()
    
    private let _typeValues: [ColorType] = [
        try! ColorType(jaName: "ノーマル", enName: "Normal", color: Color.normal),
        try! ColorType(jaName: "ほのお", enName: "Fire", color: Color.fire),
        try! ColorType(jaName: "みず", enName: "Water", color: Color.water),
        try! ColorType(jaName: "くさ", enName: "Grass", color: Color.grass),
        try! ColorType(jaName: "でんき", enName: "Electric", color: Color.electric),
        try! ColorType(jaName: "こおり", enName: "Ice", color: Color.ice),
        try! ColorType(jaName: "かくとう", enName: "Fighting", color: Color.fighting),
        try! ColorType(jaName: "どく", enName: "Poison", color: Color.poison),
        try! ColorType(jaName: "じめん", enName: "Ground", color: Color.ground),
        try! ColorType(jaName: "ひこう", enName: "Flying", color: Color.flying),
        try! ColorType(jaName: "エスパー", enName: "Psychic", color: Color.psychic),
        try! ColorType(jaName: "むし", enName: "Bug", color: Color.bug),
        try! ColorType(jaName: "いわ", enName: "Rock", color: Color.rock),
        try! ColorType(jaName: "ゴースト", enName: "Ghost", color: Color.ghost),
        try! ColorType(jaName: "ドラゴン", enName: "Dragon", color: Color.dragon),
        try! ColorType(jaName: "あく", enName: "Dark", color: Color.dark),
        try! ColorType(jaName: "はがね", enName: "Steel", color: Color.steel),
        try! ColorType(jaName: "フェアリー", enName: "Fairy", color: Color.fairy),
    ]
    
    public func getColorType(name: String) throws -> ColorType {
        if let value = _typeValues.first(where: { $0.jaName == name || $0.enName == name}) {
            return value
        }
        throw NSError(domain: "対象のタイプが存在しません", code: -1)
    }
    
    struct ColorType {
        private let _jaName: String
        private let _enName: String
        private let _color: Color
        
        public var jaName: String {
            _jaName
        }
        
        public var enName: String {
            _enName
        }
        
        public var color: Color {
            _color
        }
        
        init(jaName: String, enName: String, color: Color) throws {
            if jaName.isEmpty {
                throw NSError(domain: "日本語のタイプ名が設定されていません", code: -1)
            }
            
            if enName.isEmpty {
                throw NSError(domain: "英語のタイプ名が設定されていません", code: -1)
            }
            
            _jaName = jaName
            _enName = enName
            _color = color
        }
    }
}
