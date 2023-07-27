//
//  StoreIntroduceState.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import ComposableArchitecture

struct StoreIntroduceState: Equatable {
    
    var introduceText: String
    
    init(_ store: StoreEntity) { self.introduceText = store.announcement }
}

enum StoreIntroduceAction: Equatable {
    case textFieldChanged(String)
    case tapBottomButton
}

struct StoreIntroduceEnvironment {
    
}

let storeIntroduceReducer = AnyReducer<StoreIntroduceState, StoreIntroduceAction, StoreIntroduceEnvironment> { state, action, environment in
    
    switch action {
    case let .textFieldChanged(text):
        state.introduceText = text
        return .none
        
    case .tapBottomButton:
        // TODO: 통신 추가
        return .none
    }
}
