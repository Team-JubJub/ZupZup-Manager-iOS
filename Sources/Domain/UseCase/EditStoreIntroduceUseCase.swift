//
//  EditStoreIntroduceUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol EditStoreIntroduceUseCase {
    func editStoreIntroduce(
        request: EditStoreIntroduceRequest,
        completion: @escaping (Result<EditStoreIntroduceResponse, EditStoreIntroduceError>) -> Void
    )
}

final class EditStoreIntroduceUseCaseImpl: EditStoreIntroduceUseCase {
    
    private let editStoreIntroduceRepository: EditStoreIntroduceRepository
    
    init(editStoreIntroduceRepository: EditStoreIntroduceRepository = EditStoreIntroduceRepositoryImpl()) {
        self.editStoreIntroduceRepository = editStoreIntroduceRepository
    }
    
    func editStoreIntroduce(
        request: EditStoreIntroduceRequest,
        completion: @escaping (Result<EditStoreIntroduceResponse, EditStoreIntroduceError>) -> Void
    ) {
        editStoreIntroduceRepository.editStoreIntroduce(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
