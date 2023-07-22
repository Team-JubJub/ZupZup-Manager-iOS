//
//  AddItemUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import UIKit

protocol AddItemUseCase {
    func addItem(request: AddItemRequest, completion: @escaping (Result<AddItemResponse, NetworkError>) -> Void)
}

final class AddItemUseCaseImpl: AddItemUseCase {
    
    let addItemRepository: AddItemRepository
    
    init(addItemRepository: AddItemRepository = AddItemRepositoryImpl()) {
        self.addItemRepository = addItemRepository
    }
    
    func addItem(request: AddItemRequest, completion: @escaping (Result<AddItemResponse, NetworkError>) -> Void) {
        
        addItemRepository.addItem(request: request) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
