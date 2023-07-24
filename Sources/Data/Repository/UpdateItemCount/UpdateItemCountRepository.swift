//
//  UpdateItemCountRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol UpdateItemCountRepository {
    func updateItemCount(
        request: UpdateItemCountRequest,
        completion: @escaping (Result<UpdateItemCountResponse, NetworkError>) -> Void
    )
}

final class UpdateItemCountRepositoryImpl: UpdateItemCountRepository {

    func updateItemCount(
        request: UpdateItemCountRequest,
        completion: @escaping (Result<UpdateItemCountResponse, NetworkError>) -> Void
    ) {
        
        let storeId = LoginManager.shared.getStoreId()
        
        let url = "https://zupzuptest.com:8080/seller/\(String(describing: storeId))/quantity"
        
        NetworkManager.shared.sendRequest(
            to: url,
            method: .patch,
            parameters: request
        ) { (result: Result<UpdateItemCountResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                #if DEBUG
                print("⭐️ 제품 개수 변경 API 호출 실패 ⭐️")
                #endif
                completion(.failure(error))
            }
        }
    }
}
