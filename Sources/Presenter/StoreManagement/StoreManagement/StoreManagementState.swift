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
    case isShowingEditStoreInfoBinding // isShowingEditStoreInfo 변수 바인딩
    case openStoreResponse(Result<OpenStoreResponse, NetworkError>) // 가게 ON/OFF API 호출의 결과
    case fetchStore // 가게 정보 조희 API 호출
    case fetchStoreResponse(Result<StoreEntity, NetworkError>) // 가게 정보 조희 API 호출의 결과
}

struct StoreManagementEnvironment {
    let openStore: (OpenStoreRequest) -> EffectPublisher<Result<OpenStoreResponse, NetworkError>, Never> // 가게 ON/OFF
    let fetchStore: () -> EffectPublisher<Result<StoreEntity, NetworkError>, Never> // 가게 정보 조희
}

let storeManagementReducer = AnyReducer<StoreManagementState, StoreManagementAction, StoreManagementEnvironment> { state, action, environment in
    switch action {
    case .tapToggle: // 가게 On / Off 토글
        return environment.openStore(OpenStoreRequest(openOrClose: !state.storeEntity.isOpen))
            .map(StoreManagementAction.openStoreResponse)
            .eraseToEffect()
        
    case .tapInfoButton: // 가게 세부 정보 네비게이션
        state.isShowingEditStoreInfo = true
        return .none
        
    case .isShowingEditStoreInfoBinding: // isShowingEditStoreInfo 변수 바인딩
        state.isShowingEditStoreInfo = false
        return .none
        
    case let .openStoreResponse(.success(response)): // 가게 ON/OFF API 호출의 결과 - 성공
        state.storeEntity.isOpen.toggle()
        return .none
        
    case let .openStoreResponse(.failure(error)): // 가게 ON/OFF API 호출의 결과 - 실패
        return .none
        
    case .fetchStore: // 가게 정보 조희 API 호출
        return environment.fetchStore()
            .map(StoreManagementAction.fetchStoreResponse)
            .eraseToEffect()
        
    case let .fetchStoreResponse(.success(storeEntity)): // 가게 정보 조희 API 호출의 결과 - 성공
        state.storeEntity = storeEntity
        return .none
        
    case let .fetchStoreResponse(.failure(error)): // 가게 정보 조희 API 호출의 결과 - 실패
        // TODO: Error Handling
        return .none
    }
}
