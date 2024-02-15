//
//  ChangeReserveStateRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol ChangeJustStateRepository {
    func changeState(
        request: ChangeJustStateRequest,
        completion: @escaping (Result<ChangeStateResponse, ChangeStateError>) -> Void
    )
}

final class ChangeJustStateRepositoryImpl: ChangeJustStateRepository {
    func changeState(
        request: ChangeJustStateRequest,
        completion: @escaping (Result<ChangeStateResponse, ChangeStateError>) -> Void
    ) {
        
        let storeId = LoginManager.shared.getStoreId()
        
        let url = {
            switch request.state {
            case .cancel:
                return UrlManager.baseUrl + "/seller/\(storeId)/order/new-order/\(request.orderId)/cancel"
            case .complete:
                return UrlManager.baseUrl + "/seller/\(storeId)/order/confirmed-order/\(request.orderId)/complete"
            }
        }()
        
        NetworkManager.shared.sendRequest(
            to: url,
            method: .patch
        ) { (result: Result<ChangeStateResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                switch error.code {
                case 400:
                    completion(.failure(.badRequest))
                case 401:
                    completion(.failure(.tokenExpired))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unKnown))
                }
            }
        }
    }
    
    func changeState(request: ChangeJustStateRequest) async throws -> ChangeStateResponse {
        let response = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<ChangeStateResponse, Error>) in
            
            let storeId = LoginManager.shared.getStoreId()
            
            let url = {
                switch request.state {
                case .cancel:
                    return UrlManager.baseUrl + "/seller/\(storeId)/order/new-order/\(request.orderId)/cancel"
                case .complete:
                    return UrlManager.baseUrl + "/seller/\(storeId)/order/confirmed-order/\(request.orderId)/complete"
                }
            }()
            
            NetworkManager.shared.sendRequest(
                to: url,
                method: .get
            ) { (result: Result<ChangeStateResponse, NetworkError>) in
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
