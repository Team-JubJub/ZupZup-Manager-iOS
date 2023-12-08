//
//  DeleteStoreState.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/07.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

// MARK: TCA-State
struct DeleteStoreState: Equatable {
    let name: String
    var isShowingAlert: Bool = false
    
    var isErrorOn: Bool = false
    var errorTitle: String = ""
    var errorMessage: String = ""
    
    init(name: String) {
        self.name = name
    }
}

// MARK: TCA-Action
enum DeleteStoreAction: Equatable {
    case tapBottomButton
    
    case deleteStoreResponse(Result<DeleteStoreResponse, DeleteStoreError>)
    
    case dismissAlert
    case tabAlertOk
    case tabAlertCancel
    
    case isErrorDismiss
}

// MARK: TCA-Environment
struct DeleteStoreEnvironment {
    var deleteStore: () -> EffectPublisher<Result<DeleteStoreResponse, DeleteStoreError>, Never>
}

// MARK: TCA-Reducer
let deleteStoreReducer = AnyReducer<DeleteStoreState, DeleteStoreAction, DeleteStoreEnvironment> { state, action, environment in
    
    switch action {
    case .tapBottomButton:
        state.isShowingAlert = true
        return .none
        
    case .dismissAlert:
        state.isShowingAlert = false
        return .none
        
    case .tabAlertCancel:
        state.isShowingAlert = false
        return .none
        
    case let .deleteStoreResponse(.success(response)):
        LoginManager.shared.deleteStore()
        return .none
        
    case let .deleteStoreResponse(.failure(error)):
        switch error {
        case .badRequest:
            state.errorTitle = "경고"
            state.errorMessage = "이미 탈퇴한 회원이에요!"
            state.isErrorOn = true
        case .serverError:
            state.errorTitle = "서버 에러"
            state.errorMessage = "서버에 에러가 발생했어요!"
            state.isErrorOn = true
        default:
            state.errorTitle = "에러 발생"
            state.errorMessage = "알 수 없는 에러가 발생했어요."
            state.isErrorOn = true
        }
        
        return .none
        
    case .tabAlertOk:
        return environment.deleteStore()
            .map(DeleteStoreAction.deleteStoreResponse)
            .eraseToEffect()
        
    case .isErrorDismiss:
        state.isErrorOn = false
        return .none
    }
}
