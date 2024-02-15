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
        completion: @escaping (Result<EditStoreIntroduceResponse, EditStoreIntroduceError>) -> Void
    )
}

final class EditStoreIntroduceRepositoryImpl: EditStoreIntroduceRepository {
    
    func editStoreIntroduce(
        request: EditStoreIntroduceRequest,
        completion: @escaping (Result<EditStoreIntroduceResponse, EditStoreIntroduceError>) -> Void
    ) {
        
        let url = UrlManager.baseUrl + "/seller/notice/\(LoginManager.shared.getStoreId())"
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
                switch response.response?.statusCode {
                case 400:
                    completion(.failure(.noToken))
                case 401:
                    completion(.failure(.tokenExpired))
                case 403:
                    completion(.failure(.notAllowed))
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
    
    func editStoreIntroduce(request: EditStoreIntroduceRequest) async throws -> EditStoreIntroduceResponse {
        let url = UrlManager.baseUrl + "/seller/notice/\(LoginManager.shared.getStoreId())"
        let headers: HTTPHeaders = [ "accessToken": LoginManager.shared.getAccessToken() ]
        let parameters: [String: Any] = [ "storeMatters": request.storeMatters ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: .post,
                parameters: parameters,
                headers: headers
            )
            .responseString { response in
                switch response.result {
                case .success:
                    continuation.resume(returning: EditStoreIntroduceResponse())
                case .failure:
                    switch response.response?.statusCode {
                    case 400:
                        continuation.resume(throwing: EditStoreIntroduceError.noToken)
                    case 401:
                        continuation.resume(throwing: EditStoreIntroduceError.tokenExpired)
                    case 403:
                        continuation.resume(throwing: EditStoreIntroduceError.notAllowed)
                    case 404:
                        continuation.resume(throwing: EditStoreIntroduceError.noStore)
                    case 500:
                        continuation.resume(throwing: EditStoreIntroduceError.serverError)
                    default:
                        continuation.resume(throwing: EditStoreIntroduceError.unKnown)
                    }
                }
            }
        }
    }
}
