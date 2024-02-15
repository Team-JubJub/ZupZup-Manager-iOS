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
        let url = UrlManager.baseUrl + "/seller/\(storeId)"
        
        NetworkManager.shared.sendRequest(
            to: url,
            method: .get
        ) { (result: Result<FetchStoreResponse, NetworkError>) in
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
    
    func fetchStore() async throws -> FetchStoreResponse {
        
        let storeId = LoginManager.shared.getStoreId()
        let url = UrlManager.baseUrl + "/seller/\(storeId)"
        
        return try await withCheckedThrowingContinuation { continuation in
            NetworkManager.shared.sendRequest(
                to: url,
                method: .get
            ) { (result: Result<FetchStoreResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    switch error.code {
                    case 400:
                        continuation.resume(throwing: FetchStoreError.noToken)
                    case 401:
                        continuation.resume(throwing: FetchStoreError.tokenExpired)
                    case 403:
                        continuation.resume(throwing: FetchStoreError.noPermission)
                    case 404:
                        continuation.resume(throwing: FetchStoreError.noStore)
                    case 500:
                        continuation.resume(throwing: FetchStoreError.serverError)
                    default:
                        continuation.resume(throwing: FetchStoreError.unKnown)
                    }
                }
            }
        }
    }
}
