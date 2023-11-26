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
    
    // API관련
    var isLoading: Bool = false // API 호출 사이 인디케이터 트리거
    
    // 텍스트 필드 관련
    var id: String = ""
    var password: String = ""
    
    // 색상 변경 관련
    var failCount: Int = 0
    var textFieldColor: Color = .designSystem(.ivoryGray300)!
    var buttonBodyColor: Color = .designSystem(.neutralGray150)!
    var buttonTextColor: Color = .designSystem(.neutralGray400)!
    
    var isErrorOn: Bool = false
    var errorTitle: String = ""
    var errorMessage: String = ""
}

// MARK: TCA - Action
enum LoginAction: Equatable {
    
    // 텍스트 필드 관련
    case idChanged(String)                                              // 텍스트 필드 ID 업데이트
    case passwordChanged(String)                                        // 텍스트 필드 Password 업데이트
    
    // 터치 액션 관련
    case tapLoginButton                                                 // 로그인 버튼을 누른 경우
    case tapEmptySpace                                                  // 빈 화면을 터치한 경우
    case tapFindMyAcoount                                               // 내 계정 찾기를 터치한 경우
    case tapMakeAccount                                                 // 회원가입을 터치한 경우
    
    // API관련
    case loginRequestResult(Result<LoginResponse, LoginError>)          // 로그인 API Response 받은 경우
    
    // 색상 변경 관련
    case textFieldColorChanged                                          // textFieldColor 바인딩 함수
    case buttonBodyColorChanged                                         // buttonBodyColor 바인딩 함수
    case buttonTextColorChanged                                         // buttonTextColor 바인딩 함수
    
    case isErrorDismiss
}

// MARK: TCA - Environment
struct LoginEnvironment {
    var loginRepository: LoginRepository
    var login: (LoginRequest) -> EffectPublisher<Result<LoginResponse, LoginError>, Never>
    let openFindMyAcoountURL: () -> Void // 내 계정 찾기 URL로 전환
    let openMakeAccountURL: () -> Void // 회원가입 URL로 전환
}

// MARK: TCA - Reducer
let loginReducer = AnyReducer<LoginState, LoginAction, LoginEnvironment> { state, action, environment in
    
    switch action {
        
    // 텍스트 필드 관련
    case let .idChanged(id): // 텍스트 필드 ID 업데이트
        state.id = id
        
        if !state.id.isEmpty && !state.password.isEmpty {
            state.textFieldColor = .designSystem(.Tangerine300)!
            state.buttonBodyColor = .designSystem(.Tangerine300)!
            state.buttonTextColor = .designSystem(.pureBlack)!
        } else {
            state.textFieldColor = .designSystem(.ivoryGray300)!
            state.buttonBodyColor = .designSystem(.neutralGray150)!
            state.buttonTextColor = .designSystem(.neutralGray400)!
        }
        
        return .none
        
    case let .passwordChanged(password): // 텍스트 필드 Password 업데이트
        state.password = password
        
        if !state.id.isEmpty && !state.password.isEmpty {
            state.textFieldColor = .designSystem(.Tangerine300)!
            state.buttonBodyColor = .designSystem(.Tangerine300)!
            state.buttonTextColor = .designSystem(.pureBlack)!
        } else {
            state.textFieldColor = .designSystem(.ivoryGray300)!
            state.buttonBodyColor = .designSystem(.neutralGray150)!
            state.buttonTextColor = .designSystem(.neutralGray400)!
        }
        
        return .none
    
    // 터치 액션 관련
    case .tapLoginButton: // 로그인 버튼을 누른 경우
        
        let deviceToken = LoginManager.shared.getDeviceToken()
        
        let request = LoginRequest(
            loginId: state.id,
            loginPwd: state.password,
            deviceToken: deviceToken
        )
        
        state.isLoading = true
        
        return environment.login(request)
            .map(LoginAction.loginRequestResult)
            .eraseToEffect()
        
    case .tapEmptySpace: // 빈 화면을 터치한 경우
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
        return .none
        
    case .tapFindMyAcoount: // 내 계정 찾기를 터치한 경우
        environment.openFindMyAcoountURL()
        return .none
        
    case .tapMakeAccount: // 회원가입을 터치한 경우
        environment.openMakeAccountURL()
        return .none
        
    // API관련
    case let .loginRequestResult(.success(response)): // 로그인 API Response 받은 경우 - 성공
        LoginManager.shared.login(response: response)
        state.isLoading = false
        return .none
        
    case let .loginRequestResult(.failure(error)): // 로그인 API Response 받은 경우 - 실패
        state.isLoading = false
        
        if state.failCount < 5 { state.failCount += 1 }
        
        state.id = ""
        state.password = ""
        state.textFieldColor = .designSystem(.red500)!
        
        switch error {
        case .failToDecode:
            break
            
        case .failToEncode:
            break
            
        case .badRequest:
            state.errorTitle = "로그인 실패"
            state.errorMessage = "아이디와 비밀번호를 확인해주세요!"
            state.isErrorOn = true
            
        case .noStore:
            state.errorTitle = "입점이 신청이 필요해요"
            state.errorMessage = "서비스 이용을 위해서는\n줍줍 홈페이지에서 입점신청을 해주세요!"
            state.isErrorOn = true
            
        case .wrongPassword:
            state.errorTitle = "비밀번호 확인"
            state.errorMessage = "비밀번호를 확인해주세요!"
            state.isErrorOn = true
            
        case .wrongId:
            state.errorTitle = "아이디 확인"
            state.errorMessage = "아이디를 확인해주세요!"
            state.isErrorOn = true
            
        case .serverError:
            state.errorTitle = "내부 서비스 에러"
            state.errorMessage = "죄송합니다. 서버 내부에 문제가 발생했어요!"
            state.isErrorOn = true
            
        case .unKnown:
            state.errorTitle = "알수없는 에러"
            state.errorMessage = "죄송합니다. 알수 없는 에러가 발생했어요!"
            state.isErrorOn = true
        }
        
        return .none
        
    // 색상 변경 관련
    case .textFieldColorChanged: // textFieldColor 바인딩 함수
        return .none
        
    case .buttonBodyColorChanged: // buttonBodyColor 바인딩 함수
        return .none
        
    case .buttonTextColorChanged: // buttonTextColor 바인딩 함수
        return .none
        
    case .isErrorDismiss:
        state.isErrorOn = false
        return .none
    }
}
