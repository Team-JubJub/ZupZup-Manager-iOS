//
//  ManageStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

// MARK: TCA - State
struct ItemManageState: Equatable {
    
    var items: [ItemEntity] = []
    var store = StoreEntity()
    
    var isEditable = false // 애션 시트 호출
    var isLoading = false // 로딩 인디케이터 호출
    
    var isEditCountVisible = false // EditCountView호출
    var isAddItemVisible = false // AddItemView 호출
    var isEditInfoVisible = false // EditInfoView 호출
}

// MARK: TCA - Action
enum ItemManageAction: Equatable {
    case fetchStore
    case storeFetched(Result<StoreEntity, NetworkError>)
    case tapEditButton // 좌측 상단의 연필 모양 눌렀을 경우
    case tapEditCountButton // 액션 시트 - 제품 수량 수정
    case tapAddItemButton // 액션 시트 - 제품 추가
    case tapEditInfoButton // 액션 시트 - 제품 정보 수정
}

// MARK: TCA - Environment
struct ItemManageEnvironment {
    let fetchStoreUseCase: FetchStoreUseCase
    let updateItemCountUseCase: UpdateItemCountUseCase
    var store: (Int) -> EffectPublisher<Result<StoreEntity, NetworkError>, Never>
}

let itemManageReducer = AnyReducer<ItemManageState, ItemManageAction, ItemManageEnvironment> { state, action, environment in
    
    switch action {
    case .fetchStore:
        state.isLoading = true
        return environment.store(9)
            .map(ItemManageAction.storeFetched)
            .eraseToEffect()
        
    case let .storeFetched(.success(store)):
        state.store = store
        state.isLoading = false
        return .none
        
    case let .storeFetched(.failure(error)):
        print("제품 조회 API호출 실패")
        return .none
        
    case .tapEditButton:
        withAnimation { state.isEditable.toggle() }
        return .none
        
    case .tapEditCountButton: // 수량 수정을 눌렀을 경우
        state.isEditCountVisible.toggle()
        return .none
        
    case .tapEditInfoButton: // 제품 정보 수정을 눌렀을 경우
        state.isEditInfoVisible.toggle()
        return .none
        
    case .tapAddItemButton: // 제품 추가를 눌렀을 경우
        state.isAddItemVisible.toggle()
        return .none
    }
}
