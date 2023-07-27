//
//  EditStoreIntroduceRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol EditStoreIntroduceRepository {
    func editStoreIntroduce(request: EditStoreIntroduceRequest, completion: @escaping (Result<Void, NetworkError>) -> Void)
}

final class EditStoreIntroduceRepositoryImpl: EditStoreIntroduceRepository {
    
    func editStoreIntroduce(request: EditStoreIntroduceRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
        let url = "https://zupzuptest.com:8080/seller/notice/\(LoginManager.shared.getStoreId())/\(request.storeMatters)"
        
        NetworkManager.shared.justRequest(
            to: url,
            method: .post
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case.failure:
                completion(.failure(NetworkError.invalidResponse))
            }
        }
    }
}
