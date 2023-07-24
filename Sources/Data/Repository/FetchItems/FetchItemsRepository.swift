//
//  FetchItemsRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol FetchItemsRepository {
    func fetchItems(completion: @escaping(Result<FetchItemsResponse, NetworkError>) -> Void)
}

final class FetchItemsRepositoryImpl: FetchItemsRepository {
    
    func fetchItems(completion: @escaping (Result<FetchItemsResponse, NetworkError>) -> Void) {
        
        let storeId = LoginManager.shared.getStoreId()
        
        let url = "https://zupzuptest.com:8080/seller/\(String(describing: storeId))/management"
        
        NetworkManager.shared.sendRequest(
            to: url,
            method: .get
        ) { (result: Result<FetchItemsResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                #if DEBUG
                print("⭐️ 제품 조회 API 호출 실패 ⭐️")
                #endif
                completion(.failure(error))
            }
        }
    }
}
