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
        request: UpdateItemCountRequest,
        completion: @escaping (Result<UpdateItemCountResponse, UpdateItemCountError>) -> Void
    )
}

class UpdateItemCountUseCaseImpl: UpdateItemCountUseCase {
    
    let updateItemCountRepository: UpdateItemCountRepository
    
    init(updateItemCountRepository: UpdateItemCountRepository = UpdateItemCountRepositoryImpl()) {
        self.updateItemCountRepository = updateItemCountRepository
    }
    
    func updateItemCount(
        request: UpdateItemCountRequest,
        completion: @escaping (Result<UpdateItemCountResponse, UpdateItemCountError>) -> Void
    ) {
        updateItemCountRepository.updateItemCount(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
