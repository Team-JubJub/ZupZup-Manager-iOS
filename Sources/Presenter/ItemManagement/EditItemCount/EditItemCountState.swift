//
//  EditItemCountState.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import ComposableArchitecture

@Reducer
struct EditItemCount {
    
    @Dependency(\.editItemCount) var editItemCount
    
    struct State: Equatable {
        var items: [ItemEntity]
        var isLoading: Bool = false
        var isShowingAlert: Bool = false
        var isPop: Bool = false
    }
    
    enum Action {
        case tapPlusAction(Int)
        case tapMinusAction(Int)
        case tapBottomButton
        case dismissAlert
        case alertCancelButton
        case alertOkButton
        case updateItemCountResponse(Result<UpdateItemCountResponse, Error>) // 제품 수량 수정 API의 결과
    }
    
    var body: some Reducer<State, Action> {
        
        Reduce { state, action in
            switch action {
            case let .tapPlusAction(idx):               // 특정 제품 더하기 버튼을 누른 경우
                state.items[idx].count += 1
                return .none
                
            case let .tapMinusAction(idx):              // 특정 제품 빼기 버튼을 누른 경우
                if state.items[idx].count > 0 {
                    state.items[idx].count -= 1
                }
                return .none
                
            case .tapBottomButton:                      // 하단 수정 완료 버튼을 누른 경우
                state.isShowingAlert = true
                return .none
                
            case .dismissAlert:                         // Alert 트리거 바인딩 함수
                state.isShowingAlert = false
                return .none
                
            case .alertCancelButton:                    // 경고창 취소 버튼을 누른 경우
                state.isShowingAlert = false
                return .none
                
            case .alertOkButton:                        // 경고창 OK 버튼을 누른 경우
                state.isLoading = true
                
                let quantity = state.items.map { item in
                    UpdateItemCountRequest.Quantity(
                        itemId: item.itemId,
                        itemName: item.name,
                        imageURL: item.imageUrl,
                        itemPrice: item.priceOrigin,
                        salePrice: item.priceDiscount,
                        itemCount: item.count
                    )
                }
                let request = UpdateItemCountRequest(quantity: quantity)
                return .run { send in
                    await send(
                        .updateItemCountResponse(Result {
                            try await self.editItemCount.editItemCount(request)
                        })
                    )
                }
                
            case let .updateItemCountResponse(.success(response)): // 제품 수량 수정 API의 결과가 성공
                state.isLoading = false
                state.isPop = true
                return .none
                
            case let .updateItemCountResponse(.failure(error)): // 제품 수량 수정 API의 결과가 실패
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

// TODO: Refactor tho same name "UpdateItemCount" and "EditItemCount"
struct EditItemCountClient {
    var editItemCount: (UpdateItemCountRequest) async throws -> UpdateItemCountResponse
}

extension EditItemCountClient: DependencyKey {
    static var liveValue = EditItemCountClient(
        editItemCount: { request in
            let response = try await UpdateItemCountRepositoryImpl().updateItemCount(request: request)
            return response
        }
    )
}

extension DependencyValues {
    var editItemCount: EditItemCountClient {
        get { self[EditItemCountClient.self] }
        set { self[EditItemCountClient.self] = newValue }
    }
}
