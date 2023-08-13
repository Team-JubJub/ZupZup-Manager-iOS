//
//  EditItemCountState.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import ComposableArchitecture

// MARK: TCA - State
struct EditItemCountState: Equatable {
    // 제품 관련
    var items: [ItemEntity] // 제품 목록
    
    // API 호출 관련
    var isLoading: Bool = false
    
    // Alert 관련
    var isShowingAlert: Bool = false
    
    // 네비게이션 관련
    var isPop: Bool = false
}

// MARK: TCA - Action
enum EditItemCountAction: Equatable {
    // 버튼 관련
    case tapPlusAction(Int) // 특정 제품 더하기 버튼을 누른 경우
    case tapMinusAction(Int) // 특정 제품 빼기 버튼을 누른 경우
    case tapBottomButton // 하단 수정 완료 버튼을 누른 경우
    
    // Alert 관련
    case dismissAlert
    case alertCancelButton
    case alertOkButton
    
    // APi 관련
    case updateItemCountResponse(Result<UpdateItemCountResponse, NetworkError>) // 제품 수량 수정 API의 결과
}

// MARK: TCA - Environment
struct EditItemCountEnvironment {
let updateItemCount: (UpdateItemCountRequest) -> EffectPublisher<Result<UpdateItemCountResponse, NetworkError>, Never>
}

// MARK: TCA - Reducer
let editItemCountReducer = AnyReducer<EditItemCountState, EditItemCountAction, EditItemCountEnvironment> { state, action, envrionment in
    
    switch action {
    // 버튼 관련
    case let .tapPlusAction(idx): // 특정 제품 더하기 버튼을 누른 경우
        state.items[idx].count += 1
        return .none
        
    case let .tapMinusAction(idx): // 특정 제품 빼기 버튼을 누른 경우
        if state.items[idx].count > 0 {
            state.items[idx].count -= 1
        }
        return .none
        
    case .tapBottomButton: // 하단 수정 완료 버튼을 누른 경우
        state.isShowingAlert = true
        return .none
        
    // Alert 관련
    case .dismissAlert: // Alert 트리거 바인딩 함수
        state.isShowingAlert = false
        return .none
        
    case .alertCancelButton:
        state.isShowingAlert = false
        return .none
        
    case .alertOkButton:
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
        return envrionment.updateItemCount(request)
            .map(EditItemCountAction.updateItemCountResponse)
            .eraseToEffect()
        
    // APi 관련
    case let .updateItemCountResponse(.success(response)): // 제품 수량 수정 API의 결과가 성공
        state.isLoading = false
        state.isPop = true
        return .none
        
    case let .updateItemCountResponse(.failure(error)): // 제품 수량 수정 API의 결과가 실패
        // TODO: Error Handling
        state.isLoading = false
        return .none
    }
}
