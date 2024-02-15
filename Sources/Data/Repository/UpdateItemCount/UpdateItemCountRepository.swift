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
        completion: @escaping (Result<UpdateItemCountResponse, UpdateItemCountError>) -> Void
    )
}

final class UpdateItemCountRepositoryImpl: UpdateItemCountRepository {

    func updateItemCount(
        request: UpdateItemCountRequest,
        completion: @escaping (Result<UpdateItemCountResponse, UpdateItemCountError>) -> Void
    ) {
        
        let storeId = LoginManager.shared.getStoreId()
        
        let accessToken = LoginManager.shared.getAccessToken()
        
        let headers: HTTPHeaders = [
            "accessToken": accessToken,
            "Content-Type": "multipart/form-data; boundary=\(UUID().uuidString)"
        ]
        
        let url = UrlManager.baseUrl + "/seller/\(String(describing: storeId))/quantity"

        AF.upload(multipartFormData: { multipartFormData in
            do {
                let jsonData = try JSONEncoder().encode(request.quantity)
                multipartFormData.append(
                    jsonData,
                    withName: "quantity",
                    fileName: "item.json",
                    mimeType: "application/json"
                )
            } catch {
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
                completion(.success(UpdateItemCountResponse()))
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
    
    func updateItemCount(request: UpdateItemCountRequest) async throws -> UpdateItemCountResponse {
        
        let storeId = LoginManager.shared.getStoreId()
        
        let accessToken = LoginManager.shared.getAccessToken()
        
        let headers: HTTPHeaders = [
            "accessToken": accessToken,
            "Content-Type": "multipart/form-data; boundary=\(UUID().uuidString)"
        ]
        
        let url = UrlManager.baseUrl + "/seller/\(String(describing: storeId))/quantity"
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.upload(multipartFormData: { multipartFormData in
                do {
                    let jsonData = try JSONEncoder().encode(request.quantity)
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
            }, 
                      to: url,
                      headers: headers
            )
            .responseString { response in
                switch response.result {
                case .success:
                    continuation.resume(returning: UpdateItemCountResponse())
                case .failure:
                    switch response.response?.statusCode {
                    case 400:
                        continuation.resume(throwing: UpdateItemCountError.noToken)
                    case 401:
                        continuation.resume(throwing: UpdateItemCountError.tokenExpired)
                    case 404:
                        continuation.resume(throwing: UpdateItemCountError.noItem)
                    case 500:
                        continuation.resume(throwing: UpdateItemCountError.serverError)
                    default:
                        continuation.resume(throwing: UpdateItemCountError.unKnown)
                    }
                }
            }
        }
    }
}
