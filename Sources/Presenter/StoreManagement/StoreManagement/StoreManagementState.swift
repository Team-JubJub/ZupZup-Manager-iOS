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
    
    // Entity 관련
    var storeEntity: StoreEntity = StoreEntity() // 가게 정보 Entity
    
    // indicator 관련
    var isLoading = false // API 호출 사이 인디케이터 트리거
    
    // Alert 관련
    var isShowingStoreOpenAlert: Bool = false // 가게 ON/OFF 스위치 눌렀을 때, Alert
    var isShowingLogoutAlert: Bool = false // 로그아웃 버튼을 눌렀을 때, Alert
    
    // 화면 전환 관련
    var isShowingEditStoreInfo = false // 가게 정보 수정 화면 이동 트리거
    var isShowingCustomerCenter = false // 고객센터 웹페이지 이동 트리거
    var isShowingStoreIntroduce = false // 가게 소개 화면 이동 트리거
}

enum StoreManagementAction: Equatable {
    
    // 화면 전환 관련
    case tapInfoButton // 가게 세부 정보 네비게이션
    case tapCustomerCenterButton // 고객센터 버튼을 눌렀을 경우
    case tapStoreIntroduceButton // 가게소개 버튼을 눌렀을 경우
    case isShowingEditStoreInfoBinding // isShowingEditStoreInfo 변수 바인딩
    case isShowingStoreIntroduceBinding // isShowingStoreIntroduce 변수 바인딩
    
    // 가게 ON/OFF Alert 관련
    case tapToggle // 가게 On / Off 토글
    case dismissStoreOpenAlert // isShowingStoreOpenAlert 변수 바인딩
    case tapStoreAlertOk // 가게 ON/OFF Alert - 네 누른 경우
    case tapStoreAlertCancel // 가게 ON/OFF Alert - 취소 누른 경우
    
    // 로그아웃 Alert 관련
    case tapLogoutButton // 로그아웃 버튼을 눌렀을 경우
    case dismissLogoutAlert // isShowingLogoutAlert 변수 바인딩
    case tapLogoutAlertOK // 로그아웃 Alert - 네 누른 경우
    case tapLogoutAlertCancel // 로그아웃 Alert - 취소 누른 경우
    
    // API 관련
    case fetchStore // 가게 정보 조희 API 호출
    case openStoreResponse(Result<OpenStoreResponse, NetworkError>) // 가게 ON/OFF API 호출의 결과
    case fetchStoreResponse(Result<StoreEntity, NetworkError>) // 가게 정보 조희 API 호출의 결과
}

struct StoreManagementEnvironment {
    let openStore: (OpenStoreRequest) -> EffectPublisher<Result<OpenStoreResponse, NetworkError>, Never> // 가게 ON/OFF
    let fetchStore: () -> EffectPublisher<Result<StoreEntity, NetworkError>, Never> // 가게 정보 조희
    let openCustomerCenterURL: () -> Void // 고객센터 URL로 전환
}

let storeManagementReducer = AnyReducer<StoreManagementState, StoreManagementAction, StoreManagementEnvironment> { state, action, environment in
    switch action {
    case .tapToggle: // 가게 On / Off 토글
        state.isShowingStoreOpenAlert = true
        return .none
        
    case .tapInfoButton: // 가게 세부 정보 네비게이션
        state.isShowingEditStoreInfo = true
        return .none
        
    case .isShowingEditStoreInfoBinding: // isShowingEditStoreInfo 변수 바인딩
        state.isShowingEditStoreInfo = false
        return .none
        
    case let .openStoreResponse(.success(response)): // 가게 ON/OFF API 호출의 결과 - 성공
        state.storeEntity.isOpen.toggle()
        state.isLoading = false
        return .none
        
    case let .openStoreResponse(.failure(error)): // 가게 ON/OFF API 호출의 결과 - 실패
        state.isLoading = false
        return .none
        
    case .fetchStore: // 가게 정보 조희 API 호출
        state.isLoading = true
        return environment.fetchStore()
            .map(StoreManagementAction.fetchStoreResponse)
            .eraseToEffect()
        
    case let .fetchStoreResponse(.success(storeEntity)): // 가게 정보 조희 API 호출의 결과 - 성공
        state.storeEntity = storeEntity
        state.isLoading = false
        return .none
        
    case let .fetchStoreResponse(.failure(error)): // 가게 정보 조희 API 호출의 결과 - 실패
        // TODO: Error Handling
        state.isLoading = false
        return .none
        
    case .tapCustomerCenterButton: // 고객센터 버튼을 누른 경우
        environment.openCustomerCenterURL()
        return .none
        
    case .dismissStoreOpenAlert: // 가게 ON/OFF 스위치 눌렀을 때, Alert 바인딩 함수
        state.isShowingStoreOpenAlert = false
        return .none
        
    case .tapStoreAlertOk: // 가게 ON/OFF Alert - 네 누른 경우
        state.isLoading = true
        return environment.openStore(OpenStoreRequest(openOrClose: !state.storeEntity.isOpen))
            .map(StoreManagementAction.openStoreResponse)
            .eraseToEffect()
        
    case .tapStoreAlertCancel: // 가게 ON/OFF Alert - 취소 누른 경우
        state.isShowingStoreOpenAlert = false
        return .none
        
    case .tapLogoutButton:
        state.isShowingLogoutAlert = true
        return .none
        
    case .dismissLogoutAlert: // isShowingLogoutAlert 변수 바인딩
        state.isShowingLogoutAlert = false
        return .none
        
    case .tapLogoutAlertOK: // 로그아웃 Alert - 네 누른 경우
        // TODO: Logout API 연동
        return .none
        
    case .tapLogoutAlertCancel: // 로그아웃 Alert - 취소 누른 경우
        state.isShowingLogoutAlert = false
        return .none
        
    case .tapStoreIntroduceButton:
        state.isShowingStoreIntroduce = true
        return .none
        
    case .isShowingStoreIntroduceBinding:
        state.isShowingStoreIntroduce = false
        return .none
    }
}
