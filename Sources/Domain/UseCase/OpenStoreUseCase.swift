//
//  OpenStoreUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol OpenStoreUseCase {
    func openStore(request: OpenStoreRequest, completion: @escaping (Result<OpenStoreResponse, NetworkError>) -> Void)
}

final class OpenStoreUseCaseImpl: OpenStoreUseCase {
    
    let openStoreRepository: OpenStoreRepository
    
    init(openStoreRepository: OpenStoreRepository = OpenStoreRepositoryImpl()) {
        self.openStoreRepository = openStoreRepository
    }
    
    func openStore(request: OpenStoreRequest, completion: @escaping (Result<OpenStoreResponse, NetworkError>) -> Void) {
        openStoreRepository.openStore(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
