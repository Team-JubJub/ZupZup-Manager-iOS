//
//  StoreManagementStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/04.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct StoreManagementState: Equatable {
    var isToggleOn: Bool = false
    var isShowingEditStoreInfo = false
}

enum StoreManagementAction: Equatable {
    case tapToggle // 가게 On / Off 토글
    case tapInfoButton // 가게 세부 정보 네비게이션
    case isToggleOnBinding
    case isShowingEditStoreInfoBinding
}

struct StoreManagementEnvironment {
    
}

let storeManagementReducer = AnyReducer<StoreManagementState, StoreManagementAction, StoreManagementEnvironment> { state, action, environment in
    switch action {
    case .tapToggle:
        state.isToggleOn.toggle()
        return .none
        
    case .tapInfoButton:
        state.isShowingEditStoreInfo = true
        return .none
        
    case .isToggleOnBinding:
        state.isToggleOn = false
        return .none
        
    case .isShowingEditStoreInfoBinding:
        state.isShowingEditStoreInfo = false
        return .none
    }
}
