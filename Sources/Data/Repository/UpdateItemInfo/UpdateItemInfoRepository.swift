//
//  UpdateItemInfoRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import UIKit

import Alamofire

protocol UpdateItemInfoRepository {
    func updateItemInformation(
        request: UpdateItemInfoRequest,
        completion: @escaping (Result<UpdateItemInfoResponse, UpdateItemInfoError>) -> Void
    )
}

final class UpdateItemInfoRespositoryImpl: UpdateItemInfoRepository {
    
    let accessToken = LoginManager.shared.getAccessToken()
    
    func updateItemInformation(
        request: UpdateItemInfoRequest,
        completion: @escaping (Result<UpdateItemInfoResponse, UpdateItemInfoError>) -> Void
    ) {
        
        let url = "https://zupzuptest.com:8080/seller/\(LoginManager.shared.getStoreId())/\(request.itemid)"
        
        let headers: HTTPHeaders = [
            "accessToken": accessToken,
            "Content-Type": "multipart/form-data; boundary=\(UUID().uuidString)"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            do {
                let jsonData = try JSONEncoder().encode(request.item)
                multipartFormData.append(
                    jsonData,
                    withName: "item",
                    fileName: "item.json",
                    mimeType: "application/json"
                )
            } catch {
                completion(.failure(.failToEncode))
                return
            }
            
            if let imageData = request.image?.jpegData(compressionQuality: 0.8) {
                multipartFormData.append(
                    imageData,
                    withName: "image",
                    fileName: "image.jpg",
                    mimeType: "image/jpeg"
                )
            } else {
                completion(.failure(.failToEncode))
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
                completion(.success(UpdateItemInfoResponse()))
            case .failure:
                switch response.response?.statusCode {
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
