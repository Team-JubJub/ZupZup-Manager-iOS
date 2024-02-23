//
//  LoginService.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/20/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class LoginService: LoginServiceProtocol {
    private var networkRequest: Requestable
    
    static let shared = LoginService()
    
    var subscriptions = Set<AnyCancellable>()
    
    private init(networkRequest: Requestable = NetworkRequestable()) {
        self.networkRequest = networkRequest
    }
    
    func login(_ dto: LoginDTO) -> AnyPublisher<LoginResponse, NError> {
        let endPoint = LoginEndPoint.login
        let request = RequestModel(endPoints: endPoint, requestBody: dto)
        return self.networkRequest.request(request)
    }
    
    func autoLogin() -> AnyPublisher<AutoLoginResponse, NError> {
        let endPoint = LoginEndPoint.autoLogin
        let request = RequestModel(endPoints: endPoint)
        return self.networkRequest.request(request)
    }
}
