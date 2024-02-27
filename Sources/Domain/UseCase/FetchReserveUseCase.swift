//
//  FetchReserveUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol FetchReserveUseCase {
    func fetchReserve(
        request: FetchReservationsRequest?,
        completion: @escaping (Result<[OrderEntity], FetchReservationsError>) -> Void
    )
}

final class FetchReserveUseCaseImpl: FetchReserveUseCase {
    
    private let fetchReservationsRepository: FetchReservationsRepository
    
    init(fetchReservationsRepository: FetchReservationsRepository = FetchReservationsRepositoryImpl()) {
        self.fetchReservationsRepository = fetchReservationsRepository
    }
    
    func fetchReserve(
        request: FetchReservationsRequest?,
        completion: @escaping (Result<[OrderEntity], FetchReservationsError>) -> Void
    ) {
        fetchReservationsRepository.fetchReservations(
            request: request
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response.toReservations()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
