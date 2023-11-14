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
                return "https://zupzuptest.com:8080/seller/\(storeId)/order/new-order/\(request.orderId)/cancel"
            case .complete:
                return "https://zupzuptest.com:8080/seller/\(storeId)/order/confirmed-order/\(request.orderId)/complete"
            }
        }()
        
        NetworkManager.shared.sendRequest(
            to: url,
            method: .patch
        ) { (result: Result<ChangeStateResponse, Error>) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    switch error.asAFError?.responseCode {
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
}
