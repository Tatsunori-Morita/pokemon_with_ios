//
//  IAPIManager.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2023/05/31.
//

import Foundation

protocol IAPIManager {
    func get(
        url: String,
        param: [String: Any]?,
        headers: [String: String],
        completion: @escaping (Result<Data?, Error>) -> ())
}
