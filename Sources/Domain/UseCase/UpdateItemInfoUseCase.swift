//
//  UpdateItemInfoUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol UpdateItemInfoUseCase {
    func updateItemInformation(
        request: UpdateItemInfoRequest,
        completion: @escaping (Result<UpdateItemInfoResponse, NetworkError>) -> Void
    )
}

final class UpdateItemInfoUseCaseImpl: UpdateItemInfoUseCase {
    
    let updateItemInfoRepository: UpdateItemInfoRepository
    
    init(updateItemInfoRepository: UpdateItemInfoRepository = UpdateItemInfoRespositoryImpl()) {
        self.updateItemInfoRepository = updateItemInfoRepository
    }
    
    func updateItemInformation(
        request: UpdateItemInfoRequest,
        completion: @escaping (Result<UpdateItemInfoResponse, NetworkError>) -> Void
    ) {
        updateItemInfoRepository.updateItemInformation(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
