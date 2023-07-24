//
//  DeleteItemRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol DeleteItemRepository {
    func deleteItem(request: DeleteItemRequest, completion: @escaping (Result<DeleteItemResponse, NetworkError>) -> Void)
}

final class DeleteItemRepositoryImpl: DeleteItemRepository {
    
    func deleteItem(request: DeleteItemRequest, completion: @escaping (Result<DeleteItemResponse, NetworkError>) -> Void) {
        
        let url = "https://zupzuptest.com:8080/seller/\(LoginManager.shared.getStoreId())/\(request.itemId)"
        
        NetworkManager.shared.sendRequest(
            to: url,
            method: .delete) { (result: Result<DeleteItemResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure:
                    completion(.failure(.invalidResponse))
                }
        }
    }
}
