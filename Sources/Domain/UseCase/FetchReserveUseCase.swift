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
        storeId: Int,
        completion: @escaping (Result<[ReservationEntity], NetworkError>) -> Void
    )
}

final class FetchReserveUseCaseImpl: FetchReserveUseCase {
    
    private let fetchReserveRepository: FetchReserveRepository
    
    init(fetchReserveRepository: FetchReserveRepository = FetchReserveRepositoryImpl()) {
        self.fetchReserveRepository = fetchReserveRepository
    }
    
    func fetchReserve(
        storeId: Int,
        completion: @escaping (Result<[ReservationEntity], NetworkError>) -> Void
    ) {
        self.fetchReserveRepository.fetchReserve(
            storeId: storeId) { result in
                switch result {
                case .success(let reserveDTO):
                    let reservations = reserveDTO.map { $0.toReservation() }
                    completion(.success(reservations))
                case .failure:
                    completion(.failure(NetworkError.invalidResponse))
                }
        }
    }
}
