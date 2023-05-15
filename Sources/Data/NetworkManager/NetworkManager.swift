//
//  NetworkManager.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func sendRequest<T: Codable, P: Encodable>(
        to url: String,
        method: HTTPMethod,
        parameters: P? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let encodedParameters = try? JSONEncoder().encode(parameters) else {
            completion(.failure(.failToEncode))
            return
        }
        AF.request(
            url,
            method: method,
            parameters: encodedParameters,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                if let underlyingError = error.underlyingError {
                    completion(.failure(.requestFailed(underlyingError)))
                } else {
                    dump(error)
                    completion(.failure(.invalidResponse))
                }
            }
        }
    }
}
