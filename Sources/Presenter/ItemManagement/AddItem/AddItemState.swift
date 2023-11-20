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
                                                                // MARK: 텍스트 필드 관련
    var count: Int = 0                                          // 제품 개수
    var name: String = ""                                       // 제품 이름
    var price: String = ""                                      // 제품 가격
    var discountPrice: String = ""                              // 재퓸 헐안 거굑
    
                                                                // MARK: 이미지 피커 관련
    var selectedImage: UIImage?                                 // 이미지 피커에서 선택된 이미니
    var isShowingImagePicker: Bool = false                      // 이미지 피커 트리거
    var isShowingAlert: Bool = false                            // 경고 창 트리거
    
                                                                // MARK: API 호출 관련
    var isLoading: Bool = false                                 // 로딩 인디케이터 호출 변수
    
                                                                // MARK: Alert 관련
    var isShowingTitleMaxLengthAlert: Bool = false              // 제품명 20자 제한
    
                                                                // MARK: Navigation 관련
    var isPop: Bool = false                                     // 네비게이션 POP 변수
}

// MARK: TCA - Action
enum AddItemAction: Equatable {
                                                                // MARK: 텍스트 필드 관련
    case nameChanged(String)                                    // 제품 이름 텍스트 필드 업데이트
    case priceChanged(String)                                   // 제품 가격 텍스트 필드 업데이트
    case discountChanged(String)                                // 제품 할인 가격 텍스트 필드 업데이트
    case countChanged(Int)                                      // 제품 개수 텍스트 필드 업데이트
    
                                                                // MARK: 이미지 피커 관련
    case tabImagePickerButton                                   // 이미지 피커를 누른 경우
    case selectedImageChanged(UIImage?)                         // 이미지 피커에서 이미지를 선택한 경우
    case dismissImagePicker                                     // isShowingImagePicker 바인딩
    
                                                                // MARK: 버튼 관련
    case tabMinusButton                                         // 제품 개수 + 버튼 누른 경우
    case tabPlusButton                                          // 제품 개수 - 버튼 누른 경우
    case tapBottomButton                                        // 하단 제품 등록 버튼을 누른 경우
    
    case tapEmptySpace                                          // 빈 공간을 눌렀을 경우
    
                                                                // MARK: Alert 관련
    case dismissAlert                                           // isShowingAlert 바인딩
    case alertOkButton                                          // Alert - 네 누른 경우
    case alertCancelButton                                      // Alert - 아니오 누른 경우
    
    case dismissMaxLengthAlert                                  // isShowingTitleMaxLengthAlert 바인딩
    
                                                                // MARK: API 관련
    case addItemResponse(Result<AddItemResponse, AddItemError>) // 아이템 추가 API 호출의 결과
}

// MARK: TCA - Environment
struct AddItemEnvironment {
    var addItem: (AddItemRequest) -> EffectPublisher<Result<AddItemResponse, AddItemError>, Never>
}

// MARK: TCA - Reducer
let addItemReducer = AnyReducer<AddItemState, AddItemAction, AddItemEnvironment> { state, action, environment in
    
    switch action {
    case let .nameChanged(name):                                    // 이름 텍스트 필드 업데이트
        state.name = name
        if state.name.count > 20 {
            state.isShowingTitleMaxLengthAlert = true
            state.name = ""
        } else {
            state.isShowingTitleMaxLengthAlert = false
        }
        return .none
        
    case let .priceChanged(price):                                  // 가격 텍스트 필드 업데이트
        state.price = price
        return .none
        
    case let .discountChanged(discountedPrice):                     // 할인 가격 텍스트 필드 업데이트
        state.discountPrice = discountedPrice
        return .none
        
    case let .countChanged(count):                                  // 개수 텍스트 필드 업데이트
        state.count = count
        return .none
        
    case .tabImagePickerButton:                                     // 이미지 피커를 누른 경우
        state.isShowingImagePicker = true
        return .none
        
    case .tabMinusButton:                                           // 제품 개수 + 버튼 누른 경우
        if state.count >= 1 { state.count -= 1 }
        return .none
        
    case .tabPlusButton:                                            // 제품 개수 - 버튼 누른 경우
        state.count += 1
        return .none
        
    case .tapBottomButton:                                          // 하단 제품 등록 버튼을 누른 경우
        state.isShowingAlert = true
        return .none
        
    case .alertOkButton:                                            // Alert - 네 버튼을 누른 경우
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
        
    case let .addItemResponse(.success(response)):                  // 제품 추가 API의 Response
        state.isLoading = false
        state.isPop = true
        return .none
        
    case let .addItemResponse(.failure(error)):                     // 제품 추가 API의 Response
        state.isLoading = false
        switch error {
        case .tokenExpired:
            LoginManager.shared.setLoginOff()
        default:
            break
        }
        return .none
        
    case .alertCancelButton:                                        // Alert - 아니오 누른 경우
        state.isShowingAlert = false
        return .none
        
    case .tapEmptySpace:                                            // 빈 공간을 눌렀을 경우
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
        return .none
        
    case .dismissAlert:                                             // isShowingAlert 바인딩
        state.isShowingAlert = false
        return .none
        
    case .dismissImagePicker:                                       // isShowingImagePicker 바인딩
        state.isShowingImagePicker = false
        return .none
        
    case let .selectedImageChanged(image):                          // SelectedImage 바인딩
        state.selectedImage = image
        return .none
        
    case .dismissMaxLengthAlert:                                    // 20자 제한 Alert
        state.isShowingTitleMaxLengthAlert = false
        return .none
    }
}
