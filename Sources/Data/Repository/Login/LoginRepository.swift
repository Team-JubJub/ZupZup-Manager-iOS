//
//  LoginRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/17.
//  Copyright © 2023 ZupZup. All rights reserved.
//
import Foundation

import Alamofire

final class LoginRepository {
    
    func login(
        request: LoginRequest,
        completion: @escaping (Result<LoginResponse, LoginError>) -> Void
    ) {
        NetworkManager.shared.sendRequest(
            to: "https://zupzuptest.com:8080/mobile/sign-in",
            method: .post,
            parameters: request
        ) { (result: Result<LoginResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                switch error.code {
                case 400:
                    completion(.failure(.badRequest))
                case 401:
                    completion(.failure(.noStore))
                case 403:
                    completion(.failure(.wrongPassword))
                case 404:
                    completion(.failure(.wrongId))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unKnown))
                }
            }
        }
    }
}
