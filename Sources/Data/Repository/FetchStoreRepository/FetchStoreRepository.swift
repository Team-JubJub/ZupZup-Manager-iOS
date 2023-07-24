//
//  FetchStoreRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol FetchStoreRepository {
    func fetchStore(completion: @escaping (Result<FetchStoreResponse, NetworkError>) -> Void)
}

final class FetchStoreRepositoryImpl: FetchStoreRepository {
    func fetchStore(completion: @escaping (Result<FetchStoreResponse, NetworkError>) -> Void) {
        
        let storeId = LoginManager.shared.getStoreId()
        let url = "https://zupzuptest.com:8080/seller/\(storeId)"
        
        NetworkManager.shared.sendRequest(
            to: url,
            method: .get
        ) { (result: Result<FetchStoreResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
