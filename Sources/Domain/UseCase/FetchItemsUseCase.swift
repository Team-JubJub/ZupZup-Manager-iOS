//
//  FetchItemsUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol FetchItemsUseCase {
    func fetchItems(completion: @escaping (Result<[ItemEntity], FetchItemsError>) -> Void)
    
}

final class FetchItemsUseCaseImpl: FetchItemsUseCase {
    
    let fetchItemsRepository: FetchItemsRepository
    
    init(fetchItemsRepository: FetchItemsRepository = FetchItemsRepositoryImpl()) {
        self.fetchItemsRepository = fetchItemsRepository
    }
    
    func fetchItems(completion: @escaping (Result<[ItemEntity], FetchItemsError>) -> Void) {
        self.fetchItemsRepository.fetchItems { result in
            switch result {
            case .success(let response):
                completion(.success( response.map { $0.toItem() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
