//
//  PokemonViewModel.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/07.
//

import Foundation

class PokemonApiService {
    private let _number: Int

    init(number: Int) {
        _number = number
    }

    public func fetchPokemon(completion: @escaping (Pokemon) -> ()) {
        _fetchPokemon { result in
            switch result {
            case .success(let pokemon):
                completion(pokemon)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }

    private func _fetchPokemon(completion: @escaping (Result<Pokemon, Error>) -> ()) {
        APIManager.get(url: "https://pokeapi.co/api/v2/pokemon/\(_number)", completion: { result in
            switch result {
            case .success(let data):
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data!)
                    completion(.success(pokemon))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
