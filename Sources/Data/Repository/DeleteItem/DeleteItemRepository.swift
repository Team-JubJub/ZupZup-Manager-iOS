//
//  DeleteItemRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol DeleteItemRepository {
    func deleteItem(request: DeleteItemRequest, completion: @escaping (Result<DeleteItemResponse, DeleteItemError>) -> Void)
}

final class DeleteItemRepositoryImpl: DeleteItemRepository {
    
    func deleteItem(request: DeleteItemRequest, completion: @escaping (Result<DeleteItemResponse, DeleteItemError>) -> Void) {
        
        let url = "https://zupzuptest.com:8080/seller/\(LoginManager.shared.getStoreId())/\(request.itemId)"
        
        NetworkManager.shared.justRequest(
            to: url,
            method: .delete
        ) { result in
            switch result {
            case .success:
                completion(.success(DeleteItemResponse()))
            case .failure(let error):
                switch error.code {
                case 400:
                    completion(.failure(.noToken))
                case 401:
                    completion(.failure(.tokenExpired))
                case 404:
                    completion(.failure(.noItem))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unKnown))
                }
            }
        }
    }
}
