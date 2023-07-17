//
//  LoginStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/12.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Alamofire

class LoginStore: ObservableObject {
    
    @Published var id = "test123"
    @Published var password = "test123"
}

extension LoginStore: StoreProtocol {
    enum Action {
        case tapLoginButton
    }
    
    func reduce(action: Action) {
        switch action {
        case .tapLoginButton:
            self.tabLoginButton()
        }
    }
}

// Business Logic
extension LoginStore {
    func tabLoginButton() {
        // TODO: 로그인 연결
        NetworkManager.shared.sendRequest(
            to: "https://zupzuptest.com:8080/seller/test/sign-in",
            method: .post,
            parameters: LoginRequest(loginId: "test123", loginPwd: "test123")
        ) { (result
             : Result<LoginResponse, NetworkError>) in
            switch result {
            case .success(let response):
                dump(response)
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoginRequest: Encodable {
    let loginId: String
    let loginPwd: String
}

struct LoginResponse: Codable {
    let message: String
    let storeId: Int
}
