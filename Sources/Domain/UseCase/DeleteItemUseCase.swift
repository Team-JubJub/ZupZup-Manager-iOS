//
//  DeleteItemUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol DeleteItemUseCase {
    func deleteItem(
        request: DeleteItemRequest,
        completion: @escaping (Result<DeleteItemResponse, DeleteItemError>) -> Void
    )
}

final class DeleteItemUseCaseImpl: DeleteItemUseCase {
    
    let deleteItemRepository: DeleteItemRepository
    
    init(deleteItemRepository: DeleteItemRepository = DeleteItemRepositoryImpl()) {
        self.deleteItemRepository = deleteItemRepository
    }
    
    func deleteItem(
        request: DeleteItemRequest,
        completion: @escaping (Result<DeleteItemResponse, DeleteItemError>) -> Void
    ) {
        deleteItemRepository.deleteItem(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
