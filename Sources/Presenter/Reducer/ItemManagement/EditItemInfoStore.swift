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
    var isShowingDetail: Bool = false
}

enum EditItemInfoAction: Equatable {
    case tapBottomButton // 수정 완료 버튼을 눌렀을 경우
    case tapGridItem // 그리드 아이템 1개를 눌렀을 경우
    case dismissIsShowingDetail // isShowingDetail 변수 바인딩용
}
struct EditItemInfoEnvironment { }

let editItemInfoReducer = AnyReducer<EditItemInfoState, EditItemInfoAction, EditItemInfoEnvironment> { state, action, _ in
    
    switch action {
    case .tapBottomButton: // 수정 완료 버튼을 눌렀을 경우
        
        // TODO: 뒤로 가기 구현
        return .none
        
    case .tapGridItem: // 그리드 아이템 1개를 눌렀을 경우
        state.isShowingDetail = true
        return .none
        
    case .dismissIsShowingDetail:
        state.isShowingDetail = false
        return .none
    }
}
