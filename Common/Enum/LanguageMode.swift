//
//  LanguageMode.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/10/26.
//

import Foundation

enum LanguageMode: String, CaseIterable, Identifiable {
    case ja, en
    var id: Self { self }
}
