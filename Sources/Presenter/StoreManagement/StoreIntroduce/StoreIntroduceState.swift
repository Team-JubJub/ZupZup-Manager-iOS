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
    
    // 텍스트 핋드 관련
    var introduceText: String
    
    // Alert관련
    var isShowingAlert: Bool = false
    
    init(_ store: StoreEntity) { self.introduceText = store.announcement }
}

enum StoreIntroduceAction: Equatable {
    // 텍스트 필드 관련
    case textFieldChanged(String) // 텍스트 필드 변경 바인딩
    
    // 버튼 관련
    case tapBottomButton // 하단 수정 완료 버튼을 눌렀을 겨우
    
    // Alert 관련
    case dismissAlert // isShowingAlert 바인딩 함수
    case tapAlertOk // Alert - Ok를 탭한 경우
    case tapAlertCancel // Alert - Cancel을 탭한 경우
    
    // API 관련
    case editStoreIntroduceResponse(Result<EditStoreIntroduceResponse, NetworkError>) // 가게 소개 수정 API의 Response
}

struct StoreIntroduceEnvironment {
    let editStoreIntroduce: (EditStoreIntroduceRequest) -> EffectPublisher<Result<EditStoreIntroduceResponse, NetworkError>, Never>
}

let storeIntroduceReducer = AnyReducer<StoreIntroduceState, StoreIntroduceAction, StoreIntroduceEnvironment> { state, action, environment in
    
    switch action {
        
    // 텍스트 필드 관련
    case let .textFieldChanged(text): // 텍스트 필드 변경 바인딩
        // 300자 미만으로 제한
        if state.introduceText.count < 300 {
            state.introduceText = text
        }
        return .none
        
    // 버튼 관련
    case .tapBottomButton:
        state.isShowingAlert = true
        return .none
        
    // Alert 관련
    case .dismissAlert:
        state.isShowingAlert = false
        return .none
        
    case .tapAlertOk:
        let request = EditStoreIntroduceRequest(
            storeMatters: state.introduceText
        )
        return environment.editStoreIntroduce(request)
            .map(StoreIntroduceAction.editStoreIntroduceResponse)
            .eraseToEffect()
        
    case .tapAlertCancel:
        state.isShowingAlert = false
        return .none
        
    // API 관련
        
    case .editStoreIntroduceResponse(.success): // 가게 소개 수정 API의 Response - 성공
        print("success")
        return .none
        
    case .editStoreIntroduceResponse(.failure): // 가게 소개 수정 API의 Response - 실패
        return .none
    }
}
