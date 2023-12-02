//
//  FetchItemsRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol FetchItemsRepository {
    func fetchItems(completion: @escaping(Result<FetchItemsResponse, FetchItemsError>) -> Void)
}

final class FetchItemsRepositoryImpl: FetchItemsRepository {
    
    func fetchItems(completion: @escaping (Result<FetchItemsResponse, FetchItemsError>) -> Void) {
        
        let storeId = LoginManager.shared.getStoreId()
        
        let url = UrlManager.baseUrl + "/seller/\(String(describing: storeId))/management"
        
        NetworkManager.shared.sendRequest(
            to: url,
            method: .get
        ) { (result: Result<FetchItemsResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                switch error.code {
                case 400:
                    completion(.failure(.noToken))
                case 401:
                    completion(.failure(.tokenExpired))
                case 404:
                    completion(.failure(.noStore))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unKnown))
                }
            }
        }
    }
}
