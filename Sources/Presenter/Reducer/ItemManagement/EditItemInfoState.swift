//
//  ItemStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct EditItemInfoState: Equatable {
    let items: [ItemEntity]
}

enum EditItemInfoAction: Equatable {
    case tapBottomButton // 수정 완료 버튼을 눌렀을 경우
}
struct EditItemInfoEnvironment { }

let editItemInfoReducer = AnyReducer<EditItemInfoState, EditItemInfoAction, EditItemInfoEnvironment> { state, action, _ in
    
    switch action {
    case .tapBottomButton: // 수정 완료 버튼을 눌렀을 경우
        // TODO: 뒤로 가기 구현
        return .none
    }
}
