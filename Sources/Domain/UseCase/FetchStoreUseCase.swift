//
//  FetchStoreUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol FetchStoreUseCase {
    func fetchStore(completion: @escaping (Result<StoreEntity, NetworkError>) -> Void)
}

final class FetchStoreUseCaseImpl: FetchStoreUseCase {
        
    private let fetchStoreRepository: FetchStoreRepository
    
    init(fetchStoreRepository: FetchStoreRepository = FetchStoreRepositoryImpl()) {
        self.fetchStoreRepository = fetchStoreRepository
    }
    
    func fetchStore(completion: @escaping (Result<StoreEntity, NetworkError>) -> Void) {
        fetchStoreRepository.fetchStore { result in
            switch result {
            case .success(let response):
                completion(.success(response.toStoreEntity()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
