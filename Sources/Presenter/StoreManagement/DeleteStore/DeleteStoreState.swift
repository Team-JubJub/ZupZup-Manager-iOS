//
//  DeleteStoreState.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/07.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct DeleteStore {
    
    @Dependency(\.deleteStoreClient) var deleteStoreClient
    
    struct State: Equatable {
        let name: String
        var isShowingAlert: Bool = false
        var isErrorOn: Bool = false
        var errorTitle: String = ""
        var errorMessage: String = ""
        var isPop: Bool = false
        
        init(name: String) { self.name = name }
    }
    
    enum Action {
        case tapBottomButton
        case deleteStoreResponse(Result<DeleteStoreResponse, Error>)
        case dismissAlert
        case tabAlertOk
        case tabAlertCancel
        case isErrorDismiss
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapBottomButton:
                state.isShowingAlert = true
                return .none
                
            case .dismissAlert:
                state.isShowingAlert = false
                return .none
                
            case .tabAlertCancel:
                state.isShowingAlert = false
                return .none
                
            case let .deleteStoreResponse(.success(response)):
                state.isPop = true
                LoginManager.shared.deleteStore()
                return .none
                
            case let .deleteStoreResponse(.failure(error)):
                // TODO: Error Handling
//                switch error {
//                case .badRequest:
//                    state.errorTitle = "경고"
//                    state.errorMessage = "이미 탈퇴한 회원이에요!"
//                    state.isErrorOn = true
//                case .serverError:
//                    state.errorTitle = "서버 에러"
//                    state.errorMessage = "서버에 에러가 발생했어요!"
//                    state.isErrorOn = true
//                default:
//                    state.errorTitle = "에러 발생"
//                    state.errorMessage = "알 수 없는 에러가 발생했어요."
//                    state.isErrorOn = true
//                }
                
                return .none
                
            case .tabAlertOk:
                return .run { send in
                    await send(
                        .deleteStoreResponse(Result{
                            try await self.deleteStoreClient.deleteStore()
                        })
                    )
                }
                
            case .isErrorDismiss:
                state.isErrorOn = false
                return .none
            }
        }
    }
}

struct DeleteStoreClient {
    var deleteStore: () async throws -> DeleteStoreResponse
}

extension DeleteStoreClient: DependencyKey {
    static let liveValue = DeleteStoreClient(
        deleteStore: {
            return try await DeleteStoreRepositoryImpl().deleteStore()
        }
    )
}

extension DependencyValues {
    var deleteStoreClient: DeleteStoreClient {
        get {self[DeleteStoreClient.self]}
        set {self[DeleteStoreClient.self] = newValue }
    }
}
