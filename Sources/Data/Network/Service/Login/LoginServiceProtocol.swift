//
//  LoginServiceProtocol.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/20/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

protocol LoginServiceProtocol: Service {
    
    func login(_ dto: LoginDTO) -> AnyPublisher<LoginResponse, NError>
    
    func autoLogin() -> AnyPublisher<AutoLoginResponse, NError>
}
