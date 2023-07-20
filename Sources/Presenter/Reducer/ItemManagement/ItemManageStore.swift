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
    var isEditable = false
    var isAddable = false
    var isLoading = false
    var isEditCountVisible = false
    var isAddItemVisible = false
    var isEditInfoVisible = false
}

// MARK: TCA - Action
enum ItemManageAction: Equatable {
    case fetchStore
    case storeFetched(Result<StoreEntity, NetworkError>)
    case tapEditButton
    case tapEditBottomButton
    case tapPlusButton(index: Int)
    case tapMinusButton(index: Int)
    case tapItem(index: Int)
    case tapEditCountButton
    case tapAddItemButton
    case tapEditInfoButton
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
        withAnimation { state.isEditable = true }
        return .none
        
    case .tapEditBottomButton:
        // TODO: Fix
        state.isEditCountVisible.toggle()
        withAnimation { state.isEditable = false }
        return .none
        
    case let .tapPlusButton(index):
        state.items[index].amount += 1
        return .none
        
    case let .tapMinusButton(index):
        if state.items[index].amount > 0 {
            state.items[index].amount -= 1
        }
        return .none
        
    case .tapItem(index: let index): // TODO: Why?
        return .none
        
    case .tapEditCountButton:
        state.isEditCountVisible = true
        return .none
        
    case .tapAddItemButton:
        state.isAddItemVisible = true
        return .none
        
    case .tapEditInfoButton:
        state.isEditInfoVisible = true
        return .none
    }
}
