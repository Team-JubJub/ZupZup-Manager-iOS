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
        
        let url = UrlManager.baseUrl + "/seller/\(LoginManager.shared.getStoreId())/\(request.itemId)"
        
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
    
    func deleteItem(request: DeleteItemRequest) async throws -> DeleteItemResponse {
        
        let url = UrlManager.baseUrl + "/seller/\(LoginManager.shared.getStoreId())/\(request.itemId)"
        
        return try await withCheckedThrowingContinuation { continuation in
            let url = UrlManager.baseUrl + "/seller/\(LoginManager.shared.getStoreId())/\(request.itemId)"
            
            NetworkManager.shared.justRequest(
                to: url,
                method: .delete
            ) { result in
                switch result {
                case .success:
                    continuation.resume(returning: DeleteItemResponse())
                case .failure(let error):
                    switch error.code {
                    case 400:
                        continuation.resume(throwing: DeleteItemError.noToken)
                    case 401:
                        continuation.resume(throwing: DeleteItemError.tokenExpired)
                    case 404:
                        continuation.resume(throwing: DeleteItemError.noItem)
                    case 500:
                        continuation.resume(throwing: DeleteItemError.serverError)
                    default:
                        continuation.resume(throwing: DeleteItemError.unKnown)
                    }
                }
            }
        }
    }
}
