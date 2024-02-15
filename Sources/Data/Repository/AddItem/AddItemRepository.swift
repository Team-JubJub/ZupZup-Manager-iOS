//
//  AddItemRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import UIKit

import Alamofire

protocol AddItemRepository {
    func addItem(
        request: AddItemRequest,
        completion: @escaping(Result<AddItemResponse, AddItemError>
        ) -> Void
    )
}

final class AddItemRepositoryImpl: AddItemRepository {
    
    let url = UrlManager.baseUrl + "/seller/\(LoginManager.shared.getStoreId())"
    
    let accessToken = LoginManager.shared.getAccessToken()
    
    func addItem(
        request: AddItemRequest,
        completion: @escaping (Result<AddItemResponse, AddItemError>
        ) -> Void
    ) {
        
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
            
            if let imageData = request.image.jpegData(compressionQuality: 0.8) {
                multipartFormData.append(
                    imageData, 
                    withName: "image",
                    fileName: "image.jpg",
                    mimeType: "image/jpeg"
                )
            } 
        },
                  to: url,
                  headers: headers
        )
        .responseString { response in
            
            switch response.result {
            case .success:
                completion(.success(AddItemResponse()))
            case .failure:
                
                switch response.response?.statusCode {
                case 400:
                    completion(.failure(.noAccessToken))
                case 401:
                    completion(.failure(.tokenExpired))
                case 404:
                    completion(.failure(.noStore))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unKnown))
                }
            }
        }
    }

    func addItem(request: AddItemRequest) async throws -> AddItemResponse {
        let headers: HTTPHeaders = [
            "accessToken": accessToken,
            "Content-Type": "multipart/form-data; boundary=\(UUID().uuidString)"
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
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
                    continuation.resume(throwing: AddItemError.failToEncode)
                    return
                }
                
                if let imageData = request.image.jpegData(compressionQuality: 0.8) {
                    multipartFormData.append(
                        imageData,
                        withName: "image",
                        fileName: "image.jpg",
                        mimeType: "image/jpeg"
                    )
                }
            }, to: url, headers: headers)
            .responseString { response in
                switch response.result {
                case .success:
                    continuation.resume(returning: AddItemResponse())
                case .failure:
                    switch response.response?.statusCode {
                    case 400:
                        continuation.resume(throwing: AddItemError.noAccessToken)
                    case 401:
                        continuation.resume(throwing: AddItemError.tokenExpired)
                    case 404:
                        continuation.resume(throwing: AddItemError.noStore)
                    case 500:
                        continuation.resume(throwing: AddItemError.serverError)
                    default:
                        continuation.resume(throwing: AddItemError.unKnown)
                    }
                }
            }
        }
    }
}
