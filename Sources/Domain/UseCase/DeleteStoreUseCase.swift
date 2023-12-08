//
//  DeleteStoreUseCase.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol DeleteStoreUseCase {
    func deleteStore(completion: @escaping (Result<DeleteStoreResponse, DeleteStoreError>) -> Void)
}

class DeleteStoreUseCaseImpl: DeleteStoreUseCase {
    
    let deleteStoreRepository: DeleteStoreRepository
    
    init(deleteStoreRepository: DeleteStoreRepository = DeleteStoreRepositoryImpl()) {
        self.deleteStoreRepository = deleteStoreRepository
    }
    
    func deleteStore(completion: @escaping (Result<DeleteStoreResponse, DeleteStoreError>) -> Void) {
        
        deleteStoreRepository.deleteStore { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
