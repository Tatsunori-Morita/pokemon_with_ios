//
//  PokemonViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/07.
//

import Foundation

class PokemonApiService {
    public static let POKEMON_AMOUNT = 898
    public static let POKEMON_URL = "https://pokeapi.co/api/v2/pokemon/"
    public static let POKEMON_SPECIES_URL = "https://pokeapi.co/api/v2/pokemon-species/"
    private let _number: Int

    public var pokemonURL: String {
        PokemonApiService.POKEMON_URL + _number.description
    }

    public var pokemonSpeciesURL: String {
        PokemonApiService.POKEMON_SPECIES_URL + _number.description
    }

    init(number: Int) {
        _number = number
    }

    public func fetch<T: Decodable>(url: String, completion: @escaping (T) -> ()) {
        _fetch(url: url) { (result: Result<T, Error>) in
            switch result {
            case .success(let model):
                completion(model)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }

    private func _fetch<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> ()) {
        APIManager.get(url: url, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(T.self, from: data!)
                    completion(.success(result))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
