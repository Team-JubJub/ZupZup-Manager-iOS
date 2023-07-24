//
//  EditItemCountState.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import ComposableArchitecture

struct EditItemCountState: Equatable {
    var items: [ItemEntity] // 제품 목록
}

enum EditItemCountAction: Equatable {
    case tapPlusAction(Int) // 특정 제품 더하기 버튼을 누른 경우
    case tapMinusAction(Int) // 특정 제품 빼기 버튼을 누른 경우
    case tapBottomButton //
}

struct EditItemCountEnvironment {
    
}

let editItemCountReducer = AnyReducer<EditItemCountState, EditItemCountAction, EditItemCountEnvironment> { state, action, envrionment in
    
    switch action { 
    case let .tapPlusAction(idx):
        state.items[idx].amount += 1
        return .none
        
    case let .tapMinusAction(idx):
        if state.items[idx].amount > 0 {
            state.items[idx].amount -= 1
        }
        return .none
        
    case .tapBottomButton:
        return .none
    }
}
