//
//  FetchStoreRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol FetchStoreRepository {
    func fetchStore(completion: @escaping (Result<FetchStoreResponse, FetchStoreError>) -> Void)
}

final class FetchStoreRepositoryImpl: FetchStoreRepository {
    func fetchStore(completion: @escaping (Result<FetchStoreResponse, FetchStoreError>) -> Void) {
        
        let storeId = LoginManager.shared.getStoreId()
        let url = "https://zupzuptest.com:8080/seller/\(storeId)"
        
        NetworkManager.shared.sendRequest(
            to: url,
            method: .get
        ) { (result: Result<FetchStoreResponse, NetworkError>) in
            dump(result)
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                
                switch error.code {
                case 400:
                    completion(.failure(.noToken))
                case 401:
                    completion(.failure(.tokenExpired))
                case 403:
                    completion(.failure(.noPermission))
                case 404:
                    completion(.failure(.noStore))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unKnown))
                }
            }
        }
    }
}
