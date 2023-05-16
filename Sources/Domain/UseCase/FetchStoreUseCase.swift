//
//  FetchStoreUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol FetchStoreUseCase {
    func fetchStore(storeId: Int, completion: @escaping (Result<Store, Error>) -> Void)
}

final class FetchStoreUseCaseImpl: FetchStoreUseCase {
        
    private let fetchStoreRepository: FetchStoreRepository
    
    init(fetchStoreRepository: FetchStoreRepository = FetchStoreRepositoryImpl()) {
        self.fetchStoreRepository = fetchStoreRepository
    }
    
    func fetchStore(
        storeId: Int,
        completion: @escaping (Result<Store, Error>) -> Void
    ) {
        self.fetchStoreRepository.fetchStore(storeId: storeId) { result in
            switch result {
            case .success(let storeDTO):
                let store = storeDTO.toStore()
                completion(.success(store))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
