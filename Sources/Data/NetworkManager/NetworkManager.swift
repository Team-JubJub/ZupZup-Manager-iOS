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
    
    let accessToken = LoginManager.shared.getAccessToken()
    
    private init() {}
    
    func sendRequest<T: Decodable, P: Encodable>(
        to url: String,
        method: HTTPMethod,
        parameters: P? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let headers: HTTPHeaders = ["accessToken": accessToken]
        
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func sendRequest<T: Decodable>(
        to url: String,
        method: HTTPMethod,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let parameters: String? = nil
        let headers: HTTPHeaders = ["accessToken": accessToken]
        
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func justRequest(
        to url: String,
        method: HTTPMethod,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let parameters: String? = nil
        let hearders: HTTPHeaders = ["accessToken": accessToken]

        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: hearders
        )
        .validate()
        .responseString { response in
            switch response.result {
            case .success:
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
