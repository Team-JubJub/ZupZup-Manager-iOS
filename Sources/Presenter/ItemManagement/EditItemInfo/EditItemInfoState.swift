//
//  ItemStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

// MARK: TCA - State
struct EditItemInfoState: Equatable {
    // 제품 관련
    let items: [ItemEntity]
    
    // 네비게이션 관련
    var isPop: Bool = false
}

// MARK: TCA - Action
enum EditItemInfoAction: Equatable {
    // 버튼 관련
    case tapBottomButton // 수정 완료 버튼을 눌렀을 경우
}

// MARK: TCA - Environment
struct EditItemInfoEnvironment { }

// MARK: TCA - Reducer
let editItemInfoReducer = AnyReducer<EditItemInfoState, EditItemInfoAction, EditItemInfoEnvironment> { state, action, _ in
    
    switch action {
    // 버튼 관련
    case .tapBottomButton: // 수정 완료 버튼을 눌렀을 경우
        state.isPop = true
        return .none
    }
}
