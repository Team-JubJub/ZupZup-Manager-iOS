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

extension ItemManagement {
    enum TargetView {
        case editItemCount
        case editItemInfo
        case addItem
    }
}

@Reducer
struct ItemManagement {
    
    @Dependency(\.itemManagementClient) var itemManagementClient
    
    struct State: Equatable {
        var items: [ItemEntity] = [] // 제품 목록
        var isLoading = false // 로딩 인디케이터 호출
        var isEditable = false // 액션 시트 호출
        var isNavigate: Bool = false
        var targetViewType: TargetView = .addItem
    }
    
    enum Action {
        case fetchItems // 아이템 호출
        case itemsFetched(Result<[ItemEntity], Error>) // 아이템 호출 결과
        case tapEditButton // 좌측 상단의 연필 모양 눌렀을 경우
        case tapEditCountButton // 액션 시트 - 제품 수량 수정
        case tapAddItemButton // 액션 시트 - 제품 추가
        case tapEditInfoButton // 액션 시트 - 제품 정보 수정
        case dismissEditButton // 좌측 상단의 연필 모양 눌렀을 경우
        case dismissTarget
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchItems: // 제품 리스트 호출
            state.isLoading = true
            
            return .run { send in
                await send(
                    .itemsFetched(Result {
                        try await self.itemManagementClient.fetchItems()
                    })
                )
            }
            
        case let .itemsFetched(.success(items)): // 제품 리스트 호출 성공
            state.items = items
            state.isLoading = false
            return .none
            
        case let .itemsFetched(.failure(error)): // 제품 리스트 호출 실패
            // TODO: Error Handling
//            switch error {
//            case .tokenExpired:
//                LoginManager.shared.setLoginOff()
//            default:
//                break
//            }
            state.isLoading = false
            return .none
            
            // 버튼 관련
        case .tapEditButton: // 좌측 상단의 연필 모양 눌렀을 경우
            withAnimation { state.isEditable = true }
            return .none
            
        case .tapEditCountButton: // 수량 수정을 눌렀을 경우
            state.targetViewType = .editItemCount
            state.isNavigate = true
            return .none
            
        case .tapEditInfoButton: // 제품 정보 수정을 눌렀을 경우
            state.targetViewType = .editItemInfo
            state.isNavigate = true
            return .none
            
        case .tapAddItemButton: // 제품 추가를 눌렀을 경우
            state.targetViewType = .addItem
            state.isNavigate = true
            return .none
            
        case .dismissEditButton:
            state.isEditable = false
            return .none
            
        case .dismissTarget:
            state.isNavigate = false
            return .none
        }
    }
}

struct ItemManagementClient {
    var fetchItems: () async throws -> ([ItemEntity])
}

extension ItemManagementClient: DependencyKey {
    static let liveValue = Self(
        fetchItems: {
            let response = try await FetchItemsRepositoryImpl().fetchItems().map { $0.toItem() }
            return response
        }
    )
}

extension DependencyValues {
    var itemManagementClient: ItemManagementClient {
        get { self[ItemManagementClient.self] }
        set { self[ItemManagementClient.self] = newValue }
    }
}
