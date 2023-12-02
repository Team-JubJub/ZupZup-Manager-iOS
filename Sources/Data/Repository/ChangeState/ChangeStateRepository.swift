//
//  ChangeStateRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol ChangeStateRepository {
    func changeState(
        request: ChangeStateRequest,
        completion: @escaping (Result<ChangeStateResponse, ChangeStateError>) -> Void
    )
}

final class ChangeStateRepositoryImpl: ChangeStateRepository {
    func changeState(
        request: ChangeStateRequest,
        completion: @escaping (Result<ChangeStateResponse, ChangeStateError>) -> Void
    ) {
        
        let storeId = LoginManager.shared.getStoreId()
        
        let url = {
            switch request.state {
            case .cancel:
                return UrlManager.baseUrl + "/seller/\(storeId)/order/confirmed-order/\(request.orderId)/cancel"
            case .confirm:
                return UrlManager.baseUrl + "/seller/\(storeId)/order/new-order/\(request.orderId)/confirm"
            }
        }()
        
        NetworkManager.shared.sendRequest(
            to: url,
            method: .patch,
            parameters: request.body
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
}
