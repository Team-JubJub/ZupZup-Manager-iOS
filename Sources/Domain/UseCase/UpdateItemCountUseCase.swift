//
//  UpdateItemCountUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/17.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol UpdateItemCountUseCase {
    func updateItemCount(
        id: Int,
        _ to: [ItemEntity],
        completion: @escaping (Result<Void, Error>) -> Void
    )
}

class UpdateItemCountUseCaseImpl: UpdateItemCountUseCase {
    
    private let updateItemCountRepository: UpdateItemCountRepository
    
    init(updateItemCountRepository: UpdateItemCountRepository = UpdateItemCountRepositoryImpl()) {
        self.updateItemCountRepository = updateItemCountRepository
    }
    
    func updateItemCount(
        id: Int,
        _ to: [ItemEntity],
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        updateItemCountRepository.updateItemCount(
            id: id,
            to.map { $0.toMerchandiseDTO() }
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
