//
//  EditItemCountState.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import ComposableArchitecture

struct EditItemCountState: Equatable {
    var isLoading: Bool = false
    var items: [ItemEntity] // 제품 목록
}

enum EditItemCountAction: Equatable {
    case tapPlusAction(Int) // 특정 제품 더하기 버튼을 누른 경우
    case tapMinusAction(Int) // 특정 제품 빼기 버튼을 누른 경우
    case tapBottomButton // 하단 수정 완료 버튼을 누른 경우
    case updateItemCountResponse(Result<UpdateItemCountResponse, NetworkError>) // 제품 수량 수정 API의 결과
}

struct EditItemCountEnvironment {
let updateItemCount: (UpdateItemCountRequest) -> EffectPublisher<Result<UpdateItemCountResponse, NetworkError>, Never>
}

let editItemCountReducer = AnyReducer<EditItemCountState, EditItemCountAction, EditItemCountEnvironment> { state, action, envrionment in
    
    switch action { 
    case let .tapPlusAction(idx): // 특정 제품 더하기 버튼을 누른 경우
        state.items[idx].count += 1
        return .none
        
    case let .tapMinusAction(idx): // 특정 제품 빼기 버튼을 누른 경우
        if state.items[idx].count > 0 {
            state.items[idx].count -= 1
        }
        return .none
        
    case .tapBottomButton: // 하단 수정 완료 버튼을 누른 경우
        
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
        
    case let .updateItemCountResponse(.success(response)): // 제품 수량 수정 API의 결과가 성공
        // TODO: Pop Action 추가
        state.isLoading = false
        return .none
        
    case let .updateItemCountResponse(.failure(error)): // 제품 수량 수정 API의 결과가 실패
        // TODO: Error Handling
        state.isLoading = false
        return .none
    }
}
