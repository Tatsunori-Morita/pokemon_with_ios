//
//  PokemonApiService.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/07.
//

import Foundation

final class PokemonApiService {
    private let api: IAPIManager = APIAlamofireManager()
    private let _domainConfig: DomainConfig

    public var pokemonURL: String {
        _domainConfig.pokemonUrl
    }

    public var pokemonSpeciesURL: String {
        _domainConfig.speciesUrl
    }

    init(domainConfig: DomainConfig) {
        _domainConfig = domainConfig
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
        api.get(url: url, param: nil, headers: [:], completion: { result in
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
