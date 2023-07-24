//
//  ChangeReserveStateRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol ChangeJustStateRepository {
    func changeState(request: ChangeJustStateRequest, completion: @escaping (Result<ChangeStateResponse, NetworkError>) -> Void)
}

final class ChangeJustStateRepositoryImpl: ChangeJustStateRepository {
    func changeState(request: ChangeJustStateRequest, completion: @escaping (Result<ChangeStateResponse, NetworkError>) -> Void) {
        
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
        ) { (result: Result<ChangeStateResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
