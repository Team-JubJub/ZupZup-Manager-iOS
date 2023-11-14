//
//  EditStoreInfoUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol EditStoreInfoUseCase {
    func editStoreInfo(
        request: EditStoreInfoRequest,
        completion: @escaping (Result<EditStoreInfoResponse, EditStoreInfoError>) -> Void
    )
}

final class EditStoreInfoUseCaseImpl: EditStoreInfoUseCase {
    
    private let editStoreInfoRepository: EditStoreInfoRepository
    
    init(editStoreInfoRepository: EditStoreInfoRepository = EditStoreInfoRepositoryImpl()) {
        self.editStoreInfoRepository = editStoreInfoRepository
    }
    
    func editStoreInfo(
        request: EditStoreInfoRequest,
        completion: @escaping (Result<EditStoreInfoResponse, EditStoreInfoError>) -> Void
    ) {
        editStoreInfoRepository.editStoreInfo(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
