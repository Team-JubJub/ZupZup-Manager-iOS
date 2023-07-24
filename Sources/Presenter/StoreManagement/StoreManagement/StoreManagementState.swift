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
    var isShowingEditStoreInfo = false
    var storeEntity: StoreEntity = StoreEntity()
}

enum StoreManagementAction: Equatable {
    case tapToggle // 가게 On / Off 토글
    case tapInfoButton // 가게 세부 정보 네비게이션
    case isShowingEditStoreInfoBinding
    case openStoreResponse(Result<OpenStoreResponse, NetworkError>)
    case fetchStore
    case fetchStoreResponse(Result<StoreEntity, NetworkError>)
}

struct StoreManagementEnvironment {
    let openStore: (OpenStoreRequest) -> EffectPublisher<Result<OpenStoreResponse, NetworkError>, Never>
    let fetchStore: () -> EffectPublisher<Result<StoreEntity, NetworkError>, Never>
}

let storeManagementReducer = AnyReducer<StoreManagementState, StoreManagementAction, StoreManagementEnvironment> { state, action, environment in
    switch action {
    case .tapToggle:
        return environment.openStore(OpenStoreRequest(openOrClose: !state.storeEntity.isOpen))
            .map(StoreManagementAction.openStoreResponse)
            .eraseToEffect()
        
    case .tapInfoButton:
        state.isShowingEditStoreInfo = true
        return .none
        
    case .isShowingEditStoreInfoBinding:
        state.isShowingEditStoreInfo = false
        return .none
        
    case let .openStoreResponse(.success(response)):
        state.storeEntity.isOpen.toggle()
        return .none
        
    case let .openStoreResponse(.failure(error)):
        return .none
        
    case .fetchStore:
        return environment.fetchStore()
            .map(StoreManagementAction.fetchStoreResponse)
            .eraseToEffect()
        
    case let .fetchStoreResponse(.success(storeEntity)):
        state.storeEntity = storeEntity
        return .none
        
    case let .fetchStoreResponse(.failure(error)):
        // TODO: Error Handling
        return .none
    }
}
