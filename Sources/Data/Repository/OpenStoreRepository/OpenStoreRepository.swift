//
//  OpenStoreRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol OpenStoreRepository {
    func openStore(request: OpenStoreRequest, completion: @escaping (Result<OpenStoreResponse, NetworkError>) -> Void)
}

final class OpenStoreRepositoryImpl: OpenStoreRepository {
    
    let storeId = LoginManager.shared.getStoreId()
    
    func openStore(request: OpenStoreRequest, completion: @escaping (Result<OpenStoreResponse, NetworkError>) -> Void) {
        
        let url = "https://zupzuptest.com:8080/seller/open/\(storeId)?isOpened=\(request.openOrClose)"
        
        NetworkManager.shared.justRequest(
            to: url,
            method: .patch
        ) { result in
            switch result {
            case .success:
                completion(.success(OpenStoreResponse()))
            case .failure:
                completion(.failure(.invalidResponse))
            }
        }
    }
}
