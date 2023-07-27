//
//  AddItemStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture
import Combine

// MARK: TCA - State
struct AddItemState: Equatable {
    var isLoading: Bool = false
    var count: Int = 0 // 제품 개수
    var selectedImage: UIImage? // 이미지 피커에서 선택된 이미니
    var name: String = "" // 제품 이름
    var price: String = "" // 제품 가격
    var discountPrice: String = "" // 재퓸 헐안 거굑
    var isShowingImagePicker: Bool = false // 이미지 피커 트리거
    var isShowingAlert: Bool = false // 경고 창 트리거
}

// MARK: TCA - Action
enum AddItemAction: Equatable {
    case nameChanged(String) // 이름 텍스트 필드 업데이트
    case priceChanged(String) // 가격 텍스트 필드 업데이트
    case discountChanged(String) // 할인 가격 텍스트 필드 업데이트
    case countChanged(Int) // 개수 텍스트 필드 업데이트
    case tabImagePickerButton // 이미지 피커를 누른 경우
    case tabMinusButton // 제품 개수 + 버튼 누른 경우
    case tabPlusButton // 제품 개수 - 버튼 누른 경우
    case tapBottomButton // 하단 제품 등록 버튼을 누른 경우
    case alertOkButton // Alert - 네 누른 경우
    case alertCancelButton // Alert - 아니오 누른 경우
    case tapEmptySpace // 빈 공간을 눌렀을 경우
    case dismissAlert // isShowingAlert 바인딩
    case dismissImagePicker // isShowingImagePicker 바인딩
    case selectedImageChanged(UIImage?) // 이미지 피커에서 선택된 이미지 바인딩
    case addItemResponse(Result<AddItemResponse, NetworkError>) // 아이템 추가 API 호출의 결과
}

// MARK: TCA - Environment
struct AddItemEnvironment {
    var addItem: (AddItemRequest) -> EffectPublisher<Result<AddItemResponse, NetworkError>, Never>
}

// MARK: TCA - Reducer
let addItemReducer = AnyReducer<AddItemState, AddItemAction, AddItemEnvironment> { state, action, environment in
    
    switch action {
    case let .nameChanged(name): // 이름 텍스트 필드 업데이트
        state.name = name
        return .none
        
    case let .priceChanged(price): // 가격 텍스트 필드 업데이트
        state.price = price
        return .none
        
    case let .discountChanged(discountedPrice): // 할인 가격 텍스트 필드 업데이트
        state.discountPrice = discountedPrice
        return .none
        
    case let .countChanged(count): // 개수 텍스트 필드 업데이트
        state.count = count
        return .none
        
    case .tabImagePickerButton: // 이미지 피커를 누른 경우
        state.isShowingImagePicker = true
        return .none
        
    case .tabMinusButton: // 제품 개수 + 버튼 누른 경우
        if state.count >= 1 { state.count -= 1 }
        return .none
        
    case .tabPlusButton: // 제품 개수 - 버튼 누른 경우
        state.count += 1
        return .none
        
    case .tapBottomButton: // 하단 제품 등록 버튼을 누른 경우
        state.isShowingAlert = true
        return .none
        
    case .alertOkButton: // Alert - 네 버튼을 누른 경우
        state.isLoading = true
        
        guard let image = state.selectedImage else { return .none }
        guard let itemPrice = Int(state.price) else { return .none }
        guard let salePrice = Int(state.discountPrice) else { return .none }
        
        let items = AddItemRequest.Item(
            itemName: state.name,
            itemPrice: itemPrice,
            salePrice: salePrice,
            itemCount: state.count
        )
        
        let request = AddItemRequest(item: items, image: image)
        
        return environment.addItem(request)
            .map(AddItemAction.addItemResponse)
            .eraseToEffect()
        
    case let .addItemResponse(.success(response)): // 제품 추가 API의 Response
        state.isLoading = false
        return .none
        
    case let .addItemResponse(.failure(error)): // 제품 추가 API의 Response
        state.isLoading = false
        return .none
        
    case .alertCancelButton: // Alert - 아니오 누른 경우
        state.isShowingAlert = false
        return .none
        
    case .tapEmptySpace: // 빈 공간을 눌렀을 경우
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
        return .none
        
    case .dismissAlert: // isShowingAlert 바인딩
        state.isShowingAlert = false
        return .none
        
    case .dismissImagePicker: // isShowingImagePicker 바인딩
        state.isShowingImagePicker = false
        return .none
        
    case let .selectedImageChanged(image): // SelectedImage 바인딩
        state.selectedImage = image
        return .none
    }
}
