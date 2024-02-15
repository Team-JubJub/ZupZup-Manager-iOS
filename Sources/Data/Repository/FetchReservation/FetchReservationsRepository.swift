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
        completion: @escaping(Result<FetchReservationsResponse, FetchReservationsError>) -> Void
    )
}

final class FetchReservationsRepositoryImpl: FetchReservationsRepository {
    
    func fetchReservations(
        request: FetchReservationsRequest?,
        completion: @escaping(Result<FetchReservationsResponse, FetchReservationsError>) -> Void
    ) {
        
        let storeId = LoginManager.shared.getStoreId()
        
        NetworkManager.shared.sendRequest(
            to: UrlManager.baseUrl + "/seller/\(String(describing: storeId))/order",
            method: .get
        ) { (result: Result<FetchReservationsResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                switch error.code {
                case 204:
                    completion(.success(FetchReservationsResponse(orders: [])))
                case 400:
                    completion(.failure(.noToken))
                case 401:
                    completion(.failure(.tokenExpired))
                case 403:
                    completion(.failure(.noPermission))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unKnown))
                }
            }
        }
    }
    
    func fetchReservations(request: FetchReservationsRequest) async throws -> FetchReservationsResponse {
        let response = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<FetchReservationsResponse, Error>) in
            
            let storeId = LoginManager.shared.getStoreId()
            
            NetworkManager.shared.sendRequest(
                to: UrlManager.baseUrl + "/seller/\(String(describing: storeId))/order",
                method: .get
            ) { (result: Result<FetchReservationsResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(_):
                    continuation.resume(throwing: FetchReservationsError.failToDecode)
                }
            }
        }
        return response
    }
}
