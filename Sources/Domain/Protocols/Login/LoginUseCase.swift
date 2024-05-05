//
//  LoginUseCase.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/29.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

protocol LoginUseCase: UseCase {
    var service: LoginServiceProtocol { get set }
    
    func run(id: String,
             password: String,
             deviceToken: String) async throws -> LoginResponse
}
