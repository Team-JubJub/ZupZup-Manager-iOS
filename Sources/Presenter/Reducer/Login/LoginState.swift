//
//  LoginState.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/12.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Combine

import ComposableArchitecture
import Alamofire

// MARK: TCA - State
struct LoginState: Equatable {
    var id: String = "test123"
    var password: String = "test1234"
}

// MARK: TCA - Action
enum LoginAction: Equatable {
    case idChanged(String) // 텍스트 필드 ID 업데이트
    case passwordChanged(String) // 텍스트 필드 Password 업데이트
    case tapLoginButton // 로그인 버튼을 누른 경우
    case tapEmptySpace // 빈 화면을 터치한 경우
    case loginRequestResult(Result<LoginResponse, NetworkError>) // 로그인 API Response 받은 경우
}

// MARK: TCA - Environment
struct LoginEnvironment {
    var loginRepository: LoginRepository
    var login: (LoginRequest) -> EffectPublisher<Result<LoginResponse, NetworkError>, Never>
}

// MARK: TCA - Reducer
let loginReducer = AnyReducer<LoginState, LoginAction, LoginEnvironment> { state, action, environment in
    
    switch action {
    case let .idChanged(id):
        state.id = id
        return .none
        
    case let .passwordChanged(password):
        state.password = password
        return .none

    case .tapLoginButton:
        let request = LoginRequest(loginId: state.id, loginPwd: state.password)
        return environment.login(request)
            .map(LoginAction.loginRequestResult)
            .eraseToEffect()
        
    case .tapEmptySpace:
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
        return .none
        
    case let .loginRequestResult(.success(response)):
        LoginManager.shared.setStoreId(id: response.storeId)
        LoginManager.shared.setAccessToken(newToken: response.accessToken)
        LoginManager.shared.setRefresh(newToken: response.refreshToken)
        return .none
        
    case let .loginRequestResult(.failure(error)):
        return .none
    }
}
