//
//  EditStoreIntroduceRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import Alamofire

protocol EditStoreIntroduceRepository {
    func editStoreIntroduce(
        request: EditStoreIntroduceRequest,
        completion: @escaping (Result<EditStoreIntroduceResponse, NetworkError>) -> Void
    )
}

final class EditStoreIntroduceRepositoryImpl: EditStoreIntroduceRepository {
    
    func editStoreIntroduce(
        request: EditStoreIntroduceRequest,
        completion: @escaping (Result<EditStoreIntroduceResponse, NetworkError>) -> Void
    ) {
        
        let url = "https://zupzuptest.com:8080/seller/notice/\(LoginManager.shared.getStoreId())"
        let headers: HTTPHeaders = [ "accessToken": LoginManager.shared.getAccessToken() ]
        let parameters: [String: Any] = [ "storeMatters": request.storeMatters ]
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            headers: headers
        )
        .responseString { response in
            switch response.result {
            case .success:
                completion(.success(EditStoreIntroduceResponse()))
            case .failure:
                completion(.failure(NetworkError.invalidResponse))
            }
        }
    }
}
