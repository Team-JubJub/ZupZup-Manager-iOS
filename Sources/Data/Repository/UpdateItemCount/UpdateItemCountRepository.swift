//
//  UpdateItemCountRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import Alamofire

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
        
        let accessToken = LoginManager.shared.getAccessToken()
        
        let headers: HTTPHeaders = [
            "accessToken": accessToken,
            "Content-Type": "multipart/form-data; boundary=\(UUID().uuidString)"
        ]
        
        let url = "https://zupzuptest.com:8080/seller/\(String(describing: storeId))/quantity"

        AF.upload(multipartFormData: { multipartFormData in
            do {
                let jsonData = try JSONEncoder().encode(request.quantity)
                multipartFormData.append(jsonData, withName: "quantity", fileName: "item.json", mimeType: "application/json")
            } catch {
                // TODO: Error Handling
                completion(.failure(NetworkError.failToEncode))
                return
            }
        },
                  to: url,
                  method: .patch,
                  headers: headers
        )
        .responseString { response in
            switch response.result {
            case .success:
                completion(.success(UpdateItemCountResponse()))
            case .failure:
                completion(.failure(NetworkError.invalidResponse))
            }
        }

    }
}
