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
        state: ReservationState,
        completion: @escaping (Result<Bool, Error>) -> Void
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
        state: ReservationState,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        self.changeStateRepository.changeState(
            documentID: documentID,
            state: state) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let err):
                    completion(.failure(err))
                }
        }
    }
}
