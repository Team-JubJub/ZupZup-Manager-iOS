//
//  ChangeStateUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol ChangeStateUseCase {
    func changeState(
        documentID: String,
        state: ReservationCondition,
        completion: @escaping (Result<ReservationCondition, NetworkError>) -> Void
    )
}

final class ChangeStateUseCaseImpl: ChangeStateUseCase {
    
    private let changeStateRepository: ChangeStateRepository
    
    init(
        changeStateRepository: ChangeStateRepository = ChangeStateRepositoryImpl()
    ) {
        self.changeStateRepository = changeStateRepository
    }
    
    func changeState(
        documentID: String,
        state: ReservationCondition,
        completion: @escaping (Result<ReservationCondition, NetworkError>) -> Void
    ) {
        self.changeStateRepository.changeState(
            documentID: documentID,
            state: state) { result in
                switch result {
                case .success:
                    completion(.success(state))
                case .failure:
                    completion(.failure(NetworkError.invalidResponse))
                }
        }
    }
}
