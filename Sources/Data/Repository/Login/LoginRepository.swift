//
//  LoginRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/17.
//  Copyright © 2023 ZupZup. All rights reserved.
//
import Foundation

import Alamofire
//
//final class LoginRepository {
//
//    func login(
//        request: LoginRequest,
//        completion: @escaping (Result<LoginResponse, LoginError>) -> Void
//    ) {
//        NetworkManager.shared.sendRequest(
//            to: UrlManager.baseUrl + "/mobile/sign-in",
//            method: .post,
//            parameters: request
//        ) { (result: Result<LoginResponse, NetworkError>) in
//            switch result {
//            case .success(let response):
//                completion(.success(response))
//            case .failure(let error):
//                switch error.code {
//                case 400:
//                    completion(.failure(.badRequest))
//                case 401:
//                    completion(.failure(.noStore))
//                case 403:
//                    completion(.failure(.wrongPassword))
//                case 404:
//                    completion(.failure(.wrongId))
//                case 451:
//                    completion(.failure(.storeExpired))
//                case 500:
//                    completion(.failure(.serverError))
//                default:
//                    completion(.failure(.unKnown))
//                }
//            }
//        }
//    }
//}

final class LoginRepository {
    func login(request: LoginRequest) async throws -> LoginResponse {
        let response = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<LoginResponse, Error>) in
            NetworkManager.shared.sendRequest(
                to: UrlManager.baseUrl + "/mobile/sign-in",
                method: .post,
                parameters: request
            ) { (result: Result<LoginResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    switch error.code {
                    case 400:
                        continuation.resume(throwing: LoginError.badRequest)
                    case 401:
                        continuation.resume(throwing: LoginError.noStore)
                    case 403:
                        continuation.resume(throwing: LoginError.wrongPassword)
                    case 404:
                        continuation.resume(throwing: LoginError.wrongId)
                    case 451:
                        continuation.resume(throwing: LoginError.storeExpired)
                    case 500:
                        continuation.resume(throwing: LoginError.serverError)
                    default:
                        continuation.resume(throwing: LoginError.unKnown)
                    }
                }
            }
        }
        return response
    }
}
