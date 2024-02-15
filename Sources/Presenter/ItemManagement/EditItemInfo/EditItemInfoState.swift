//
//  ItemStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct EditItemInfo {
    
    @Dependency(\.editItemInfoClient) var editItemInfoClient
    
    struct State: Equatable {
        var items: [ItemEntity]
        var isPop: Bool = false
        var isLoading = false // 로딩 인디케이터 호출
    }
    
    enum Action {
        case tapBottomButton // 수정 완료 버튼을 눌렀을 경우
        case fetchItems      // 제품 패치
        case itemsFetched(Result<[ItemEntity], Error>) // 아이템 호출 결과
    }
    
    var body: some Reducer<State, Action> {
        
        Reduce { state, action in
            switch action {
                // 버튼 관련
            case .tapBottomButton: // 수정 완료 버튼을 눌렀을 경우
                state.isPop = true
                return .none
                
            case .fetchItems: // 제품 리스트 호출
                state.isLoading = true
                
                return .run { send in
                    await send(
                        .itemsFetched(Result{
                            try await editItemInfoClient.fetchItem()
                        })
                    )
                }
                
            case let .itemsFetched(.success(items)): // 제품 리스트 호출 성공
                state.items = items
                state.isLoading = false
                return .none
                
            case let .itemsFetched(.failure(error)): // 제품 리스트 호출 실패
                // TODO: Error Handling
                //                switch error {
                //                case .tokenExpired:
                //                    LoginManager.shared.setLoginOff()
                //                default:
                //                    break
                //                }
                state.isLoading = false
                return .none
                
            }
        }
    }
}

struct EditItemInfoClient {
    // TODO: Need To Add Abstraction
    var fetchItem: () async throws -> [ItemEntity]
    
}

extension EditItemInfoClient: DependencyKey {
    // TODO: Need To Refactor
    static let liveValue = Self(
        fetchItem: {
            return try await FetchItemsRepositoryImpl().fetchItems()
                .map { $0.toItem() }
        }
    )
}

extension DependencyValues {
    var editItemInfoClient: EditItemInfoClient {
        get { self[EditItemInfoClient.self] }
        set { self[EditItemInfoClient.self] = newValue }
    }
}
