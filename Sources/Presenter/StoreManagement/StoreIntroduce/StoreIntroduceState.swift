//
//  StoreIntroduceState.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import ComposableArchitecture

@Reducer
struct StoreIntroduce {
    
    @Dependency(\.storeIntroduceClient) var storeIntroduceClient
    
    struct State: Equatable {
        var introduceText: String
        var isShowingAlert: Bool = false
        var isPop: Bool = false
        
        init(_ store: StoreEntity) { self.introduceText = store.announcement }
    }
    
    enum Action {
        case textFieldChanged(String)                                                   // 텍스트 필드 변경 바인딩
        case tapBottomButton                                                            // 하단 수정 완료 버튼을 눌렀을 겨우
        case dismissAlert                                                               // isShowingAlert 바인딩 함수
        case tapAlertOk                                                                 // Alert - Ok를 탭한 경우
        case tapAlertCancel                                                             // Alert - Cancel을 탭한 경우
        case editStoreIntroduceResponse(Result<EditStoreIntroduceResponse, Error>)      // 가게 소개 수정 API의 Response
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
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
                
                return .run { send in
                    await send(
                        .editStoreIntroduceResponse(Result {
                            try await self.storeIntroduceClient.editStoreIntroduce(request)
                        })
                    )
                }
                
            case .tapAlertCancel:
                state.isShowingAlert = false
                return .none
                
                // API 관련
            case .editStoreIntroduceResponse(.success): // 가게 소개 수정 API의 Response - 성공
                state.isPop = true
                return .none
                
            case .editStoreIntroduceResponse(.failure(let error)): // 가게 소개 수정 API의 Response - 실패
                // TODO: Error Handling
                //                    switch error {
                //                    case .tokenExpired:
                //                        LoginManager.shared.setLoginOff()
                //                    default:
                //                        break
                //                    }
                return .none
            }
            
        }
    }
}

struct StoreIntroduceClient {
    var editStoreIntroduce: (EditStoreIntroduceRequest) async throws -> EditStoreIntroduceResponse
}

extension StoreIntroduceClient: DependencyKey {
    static let liveValue = StoreIntroduceClient(editStoreIntroduce: { request in
        return try await EditStoreIntroduceRepositoryImpl().editStoreIntroduce(request: request)
    })
}

extension DependencyValues {
    var storeIntroduceClient: StoreIntroduceClient {
        get { self[StoreIntroduceClient.self] }
        set { self[StoreIntroduceClient.self] = newValue }
    }
}
