//
//  ManageStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Combine

import ComposableArchitecture

// MARK: TCA - State
struct ItemManageState: Equatable {
    
    // 제품 관련
    var items: [ItemEntity] = [] // 제품 목록
    
    // API 관련
    var isLoading = false // 로딩 인디케이터 호출
    
    // 네비게이션 관련
    var isEditable = false // 액션 시트 호출
    var isEditCountVisible = false // EditCountView호출
    var isAddItemVisible = false // AddItemView 호출
    var isEditInfoVisible = false // EditInfoView 호출
}

// MARK: TCA - Action
enum ItemManageAction: Equatable {
    
    // API 관련
    case fetchItems // 아이템 호출
    case itemsFetched(Result<[ItemEntity], FetchItemsError>) // 아이템 호출 결과
    
    // 버튼 관련
    case tapEditButton // 좌측 상단의 연필 모양 눌렀을 경우
    case tapEditCountButton // 액션 시트 - 제품 수량 수정
    case tapAddItemButton // 액션 시트 - 제품 추가
    case tapEditInfoButton // 액션 시트 - 제품 정보 수정
    
    case dismissEditButton // 좌측 상단의 연필 모양 눌렀을 경우
    case dismissEditCountButton // 액션 시트 - 제품 수량 수정
    case dismissAddItemButton // 액션 시트 - 제품 추가
    case dismissEditInfoButton // 액션 시트 - 제품 정보 수정
}

// MARK: TCA - Environment
struct ItemManageEnvironment {
    var items: () -> EffectPublisher<Result<[ItemEntity], FetchItemsError>, Never>
}

// MARK: TCA - Reducer
let itemManageReducer = AnyReducer<ItemManageState, ItemManageAction, ItemManageEnvironment> { state, action, environment in
    
    switch action {
    // API 관련
    case .fetchItems: // 제품 리스트 호출
        state.isLoading = true
        return environment.items()
            .map(ItemManageAction.itemsFetched)
            .eraseToEffect()
        
    case let .itemsFetched(.success(items)): // 제품 리스트 호출 성공
        state.items = items
        state.isLoading = false
        return .none
        
    case let .itemsFetched(.failure(error)): // 제품 리스트 호출 실패
        switch error {
        case .tokenExpired:
            LoginManager.shared.setLoginOff()
        default:
            break
        }
        state.isLoading = false
        return .none
        
    // 버튼 관련
    case .tapEditButton: // 좌측 상단의 연필 모양 눌렀을 경우
        withAnimation { state.isEditable = true }
        return .none
        
    case .tapEditCountButton: // 수량 수정을 눌렀을 경우
        state.isEditCountVisible = true
        return .none
        
    case .tapEditInfoButton: // 제품 정보 수정을 눌렀을 경우
        state.isEditInfoVisible = true
        return .none
        
    case .tapAddItemButton: // 제품 추가를 눌렀을 경우
        state.isAddItemVisible = true
        return .none
        
    case .dismissEditButton:
        state.isEditable = false
        return .none
        
    case .dismissEditCountButton:
        state.isEditCountVisible = false
        return .none
        
    case .dismissAddItemButton:
        state.isAddItemVisible = false
        return .none
        
    case .dismissEditInfoButton:
        state.isEditInfoVisible = false
        return .none
    }
}
