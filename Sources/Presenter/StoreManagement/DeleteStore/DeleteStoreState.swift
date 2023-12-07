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
    
    init(name: String) {
        self.name = name
    }
}

// MARK: TCA-Action
enum DeleteStoreAction: Equatable {
    case tapBottomButton
    
}

// MARK: TCA-Environment
struct DeleteStoreEnvironment {
    
}

// MARK: TCA-Reducer
let deleteStoreReducer = AnyReducer<DeleteStoreState, DeleteStoreAction, DeleteStoreEnvironment> { state, action, environment in
    
    switch action {
    case .tapBottomButton:
        // TODO: 회원탈퇴 API 호출
        // 토큰 다 지울 것
        return .none
    }
}
