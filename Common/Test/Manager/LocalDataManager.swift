//
//  LocalDataManager.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/16.
//

import Foundation
import SwiftUI

struct LocalDataManager {
    public static let shared = LocalDataManager()

    private init() {}

    public func load<T: Decodable>(_ filename: String) -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError()
        }

        guard
            let data = try? Data(contentsOf: url),
            let model = try? JSONDecoder().decode(T.self, from: data)
        else {
            fatalError()
        }
        return model
    }
}
