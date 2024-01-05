//
//  PokemonApiService.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/07.
//

import Foundation

final class PokemonApiService {
    private let _api: IAPIManager = APIAlamofireManager()
    private let _number: Int
    
    init() {
        _number = Int.random(in: 1 ... Const.shared.getPokemonAmount)
    }
    
    public var getNumber: Int {
        _number
    }

    public var pokemonURL: String {
        "\(Const.shared.getPokemonUrl)\(_number)"
    }

    public var pokemonSpeciesURL: String {
        "\(Const.shared.getPokemonSpeciesUrl)\(_number)"
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
        _api.get(url: url, param: nil, headers: [:], completion: { result in
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
