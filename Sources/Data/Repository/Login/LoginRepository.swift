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
    
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        NetworkManager.shared.sendRequest(
            to: "https://zupzuptest.com:8080/seller/test/sign-in",
            method: .post,
            parameters: request
        ) { (result: Result<LoginResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
