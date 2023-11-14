//
//  ChangeStateUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol ChangeJustStateUseCase {
    func changeJustState(
        request: ChangeJustStateRequest,
        completion: @escaping (Result<ReservationCondition, ChangeStateError>) -> Void
    )
}

final class ChangeJustStateUseCaseImpl: ChangeJustStateUseCase {
    
    private let changeJustStateRepository: ChangeJustStateRepository
    
    init(changeJustStateRepository: ChangeJustStateRepository = ChangeJustStateRepositoryImpl()) {
        self.changeJustStateRepository = changeJustStateRepository
    }
    
    func changeJustState(
        request: ChangeJustStateRequest,
        completion: @escaping (Result<ReservationCondition, ChangeStateError>) -> Void
    ) {
        self.changeJustStateRepository.changeState(
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
