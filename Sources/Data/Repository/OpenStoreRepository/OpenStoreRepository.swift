//
//  OpenStoreRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol OpenStoreRepository {
    func openStore(
        request: OpenStoreRequest,
        completion: @escaping (Result<OpenStoreResponse, OpenStoreError>) -> Void
    )
}

final class OpenStoreRepositoryImpl: OpenStoreRepository {
    
    let storeId = LoginManager.shared.getStoreId()
    
    func openStore(
        request: OpenStoreRequest,
        completion: @escaping (Result<OpenStoreResponse, OpenStoreError>) -> Void
    ) {
        
        let url = UrlManager.baseUrl + "/seller/open/\(storeId)?isOpened=\(request.openOrClose)"
        
        NetworkManager.shared.justRequest(
            to: url,
            method: .patch
        ) { result in
            switch result {
            case .success:
                completion(.success(OpenStoreResponse()))
            case .failure(let error):
                switch error.code {
                case 400:
                    completion(.failure(.badRequest))
                case 401:
                    completion(.failure(.noStore))
                case 403:
                    completion(.failure(.wrongPassword))
                case 404:
                    completion(.failure(.wrongId))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unKnown))
                }
            }
        }
    }
}
