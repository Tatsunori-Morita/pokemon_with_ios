//
//  APIManager.swift
//  pokemon_with_ios
//
//  Created by Tatsunori on 2022/07/07.
//

import Foundation
import Alamofire

enum APIError: Error {
    case responseDataNil
}

final class APIManager: NSObject {

    public static func get(
        url: String, param: [String: Any]? = nil, headers: [String: String] = [:],
        completion: @escaping (Result<Data?, Error>) -> ()) {
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding(destination: .queryString),
                   headers: HTTPHeaders(headers)).response { response in
            switch response.result {
            case .success(_):
                guard let data = response.data else {
                    completion(.failure(APIError.responseDataNil))
                    return
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
