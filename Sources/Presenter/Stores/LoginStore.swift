//
//  LoginStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/12.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class LoginStore: ObservableObject {
    
    @Published var id = ""
    @Published var password = ""
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
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
