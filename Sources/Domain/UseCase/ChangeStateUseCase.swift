//
//  ChangeStateUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol ChangeStateUseCase {
    func changeState(
        request: ChangeStateRequest,
        completion: @escaping (Result<ReservationCondition, ChangeStateError>) -> Void
    )
}

final class ChangeStateUseCaseImpl: ChangeStateUseCase {
    
    private let changeStateRepository: ChangeStateRepository
    
    init(changeStateRepository: ChangeStateRepository = ChangeStateRepositoryImpl()) {
        self.changeStateRepository = changeStateRepository
    }
    
    func changeState(
        request: ChangeStateRequest,
        completion: @escaping (Result<ReservationCondition, ChangeStateError>) -> Void
    ) {
        self.changeStateRepository.changeState(
            request: request) { result in
                switch result {
                case .success(let response):
                    completion(.success(response.toCondition()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
