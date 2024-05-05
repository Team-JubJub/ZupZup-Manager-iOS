//
//  LoginUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/29.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class LoginUseCaseImpl: LoginUseCase {
    var service: LoginServiceProtocol
    
    var cancellables = Set<AnyCancellable>()
    
    init(service: LoginServiceProtocol = LoginService.shared) {
        self.service = service
    }
    
    func run(id: String, password: String, deviceToken: String) async throws -> LoginResponse {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<LoginResponse, Error>) in
            
            let dto = LoginDTO(loginId: id, loginPwd: password, deviceToken: deviceToken)
            
            self.service.login(dto)
                .sink { completion in
                    // TODO: Error Handling
                    
                } receiveValue: { response in
                    continuation.resume(returning: response)
                }
                .store(in: &cancellables)
        }
    }
}
