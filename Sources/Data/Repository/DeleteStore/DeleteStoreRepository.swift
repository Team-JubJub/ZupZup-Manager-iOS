//
//  DeleteStoreRepository.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import Alamofire

protocol DeleteStoreRepository {
    func deleteStore(completion: @escaping (Result<DeleteStoreResponse, DeleteStoreError>) -> Void)
}

final class DeleteStoreRepositoryImpl: DeleteStoreRepository {
    
    func deleteStore(completion: @escaping (Result<DeleteStoreResponse, DeleteStoreError>) -> Void) {
        
        let storeId = LoginManager.shared.getStoreId()
        let url = UrlManager.urlForDeleteStore + "/cancel/\(storeId)"
        
        AF.request(
            url,
            method: .patch
        )
        .validate()
        .response { response in
            switch response.result {
            case .success:
                completion(.success(DeleteStoreResponse()))
            case .failure:
                switch response.response?.statusCode {
                case 400:
                    completion(.failure(.badRequest))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unKnown))
                }
            }
        }
    }
}
