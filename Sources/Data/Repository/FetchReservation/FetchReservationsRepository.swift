//
//  FetchStoreRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/19.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol FetchReservationsRepository {
    func fetchReservations(
        request: FetchReservationsRequest?,
        completion: @escaping(Result<FetchReservationsResponse, NetworkError>) -> Void
    )
}

final class FetchReservationsRepositoryImpl: FetchReservationsRepository {
    
    func fetchReservations(request: FetchReservationsRequest?, completion: @escaping(Result<FetchReservationsResponse, NetworkError>) -> Void) {
        
        let storeId = LoginManager.shared.getStoreId()
        
        NetworkManager.shared.sendRequest(
            to: "https://zupzuptest.com:8080/seller/\(String(describing: storeId))/order",
            method: .get,
            parameters: request
        ) { (result: Result<FetchReservationsResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                #if DEBUG
                print("⭐️ 예약조회 API 호출 실패 ⭐️")
                #endif
                completion(.failure(error))
            }
        }
    }
}
