//
//  ColorSchemeMode.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/08/27.
//

import Foundation

enum ColorSchemeMode: String, CaseIterable, Identifiable {
    case light, dark
    var id: Self { self }
}
