//
//  AutoLoginRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 11/20/23.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import Alamofire

final class AutoLoginRepository {
    
    func autoLogin(
        request: AutoLoginRequest,
        completion: @escaping (Result<AutoLoginResponse, AutoLoginError>) -> Void
    ) {
        let refreshToken = request.refreshToken
        
        let parameters: String? = nil
        
        let headers: HTTPHeaders = ["refreshToken": refreshToken]
        
        let url = "https://zupzuptest.com:8080/mobile/sign-in/refresh"
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: AutoLoginResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure:
                switch response.response?.statusCode {
                case 400:
                    completion(.failure(.noRefreshToken))
                case 401:
                    completion(.failure(.tokenExpired))
                default:
                    completion(.failure(.unKnown))
                }
            }
        }
    }
}
