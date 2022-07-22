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

    public func fetchPokemonSpecies(completion: @escaping (PokemonSpecies) -> ()) {
        _fetchPokemonSpecies { result in
            switch result {
            case .success(let pokemonSpecies):
                completion(pokemonSpecies)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }

    public func fetchPokemonType(url: String, completion: @escaping (PokemonType) -> ()) {
        _fetchPokemonType(url: url) { result in
            switch result {
            case .success(let pokemonType):
                completion(pokemonType)
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
                    let result = try JSONDecoder().decode(Pokemon.self, from: data!)
                    completion(.success(result))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    private func _fetchPokemonSpecies(completion: @escaping (Result<PokemonSpecies, Error>) -> ()) {
        APIManager.get(url: "https://pokeapi.co/api/v2/pokemon-species/\(_number)", completion: { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(PokemonSpecies.self, from: data!)
                    completion(.success(result))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    private func _fetchPokemonType(url: String, completion: @escaping (Result<PokemonType, Error>) -> ()) {
        APIManager.get(url: url, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(PokemonType.self, from: data!)
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
