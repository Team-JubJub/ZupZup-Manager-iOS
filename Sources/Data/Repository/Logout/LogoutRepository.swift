//
//  LogoutRepository.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import Alamofire

final class LogoutRepository {
    
    func logout(
        request: LogoutRequest,
        completion: @escaping (Result<LogoutResponse, LogoutError>) -> Void
    ) {
        let accessToken = LoginManager.shared.getAccessToken()
        let refreshToken = LoginManager.shared.getRefreshToken()
        
        let headers: HTTPHeaders = [
            "accessToken": accessToken,
            "refreshToken": refreshToken
        ]
        
        AF.request(
            UrlManager.baseUrl + "/mobile/sign-out",
            method: .post,
            parameters: request,
            headers: headers
        )
        .validate()
        .response { response in
            dump(response)
            switch response.result {
            case .success:
                completion(.success(LogoutResponse()))
            case .failure:
                switch response.response?.statusCode {
                case 400:
                    completion(.failure(.noRefreshToken))
                case 401:
                    completion(.failure(.accessDenyed))
                case 403:
                    completion(.failure(.noAccessToken))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unKnown))
                }
            }
        }
    }
}

