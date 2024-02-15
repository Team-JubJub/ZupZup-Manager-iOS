//
//  EditStoreInfoRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import UIKit

import Alamofire

protocol EditStoreInfoRepository {
    func editStoreInfo(
        request: EditStoreInfoRequest,
        completion: @escaping (Result<EditStoreInfoResponse, EditStoreInfoError>) -> Void
    )
}

final class EditStoreInfoRepositoryImpl: EditStoreInfoRepository {
    
    let url = UrlManager.baseUrl + "/seller/modification/\(LoginManager.shared.getStoreId())"
    
    let accessToken = LoginManager.shared.getAccessToken()
    
    func editStoreInfo(request: EditStoreInfoRequest, completion: @escaping (Result<EditStoreInfoResponse, EditStoreInfoError>) -> Void) {
        
        let headers: HTTPHeaders = [
            "accessToken": accessToken,
            "Content-Type": "multipart/form-data; boundary=\(UUID().uuidString)"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            do {
                let jsonData = try JSONEncoder().encode(request.data)
                multipartFormData.append(jsonData, withName: "data", fileName: "data.json", mimeType: "application/json")
            } catch {
                completion(.failure(.failToEncode))
                return
            }
            
            if let imageData = request.image?.jpegData(compressionQuality: 0.8) {
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            } 
        },
                  to: url,
                  method: .patch,
                  headers: headers
        )
        .responseString { response in
            switch response.result {
            case .success:
                completion(.success(EditStoreInfoResponse()))
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
    
    func editStoreInfo(request: EditStoreInfoRequest) async throws -> EditStoreInfoResponse {
        let headers: HTTPHeaders = [
            "accessToken": accessToken,
            "Content-Type": "multipart/form-data; boundary=\(UUID().uuidString)"
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.upload(multipartFormData: { multipartFormData in
                do {
                    let jsonData = try JSONEncoder().encode(request.data)
                    multipartFormData.append(jsonData, withName: "data", fileName: "data.json", mimeType: "application/json")
                } catch {
                    continuation.resume(throwing: EditStoreInfoError.failToDecode)
                    return
                }
                
                if let imageData = request.image?.jpegData(compressionQuality: 0.8) {
                    multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                }
            },
                      to: url,
                      method: .patch,
                      headers: headers
            )
            .responseString { response in
                switch response.result {
                case .success:
                    continuation.resume(returning: EditStoreInfoResponse())
                case .failure:
                    switch response.response?.statusCode {
                    case 400:
                        continuation.resume(throwing: EditStoreInfoError.noToken)
                    case 401:
                        continuation.resume(throwing: EditStoreInfoError.tokenExpired)
                    case 404:
                        continuation.resume(throwing: EditStoreInfoError.noItem)
                    case 500:
                        continuation.resume(throwing: EditStoreInfoError.serverError)
                    default:
                        continuation.resume(throwing: EditStoreInfoError.unKnown)
                    }
                }
            }
        }
    }
}
