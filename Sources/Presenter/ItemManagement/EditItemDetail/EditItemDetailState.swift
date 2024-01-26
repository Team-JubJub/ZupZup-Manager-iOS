////
////  EditItemDetailStore.swift
////  ZupZupManager
////
////  Created by YeongJin Jeong on 2023/07/11.
////  Copyright © 2023 ZupZup. All rights reserved.
////
//
//import SwiftUI
//
//import ComposableArchitecture
//
//// MARK: TCA - State
//struct EditItemDetailState: Equatable {
//                                                            // MARK: 텍스트 필드 관련 변수
//    var name: String                                        // 제품 이름
//    var price: String                                       // 제품 가격
//    var discountPrice: String                               // 재퓸 헐안 거굑
//    var count: Int                                          // 제품 개수
//    
//                                                            // MARK: Alert 관련 변수
//    var isShowingAlert: Bool = false                        // 제품 삭제 Alert 트리거
//    var isShowingEditAlert: Bool = false                    // 제품 수정 Alert 관련 트리거
//    var isShowingTitleMaxLengthAlert: Bool = false          // 제품명 20자 제한
//    
//                                                            // MARK: 이미지 피커 관련 변수
//    var isShowingImagePicker: Bool = false                  // 이미지 피커 트리거
//    var selectedImage: UIImage?                             // 이미지 피커에서 선택된 이미지
//    
//    var isLoading: Bool = false
//    let itemId: Int
//    let imageUrl: String
//    
//                                                            // MARK: 네비게이션 관련 변수
//    var isPop: Bool = false                                 // 네비게이션 POP 액션
//    
//    init(item: ItemEntity) {
//        self.name = item.name
//        self.price = item.priceOrigin.toString()
//        self.discountPrice = item.priceDiscount.toString()
//        self.count = item.count
//        self.itemId = item.itemId
//        self.imageUrl = item.imageUrl
//    }
//}
//
//// MARK: TCA - Action
//enum EditItemDetailAction: Equatable {
//    
//    case nameChanged(String)                                // 이름 텍스트 필드 업데이트
//    case priceChanged(String)                               // 가격 텍스트 필드 업데이트
//    case discountChanged(String)                            // 할인 가격 텍스트 필드 업데이트
//    case countChanged(Int)                                  // 개수 텍스트 필드 업데이트
//    
//    case tabClearButton
//    
//    case tabImagePickerButton                               // 이미지 피커를 누른 경우
//    case tabMinusButton                                     // 제품 개수 - 버튼 누른 경우
//    case tabPlusButton                                      // 제품 개수 + 버튼 누른 경우
//    case tapBottomButton                                    // 하단 제품 등록 버튼을 누른 경우
//    case tapEmptySpace                                      // 빈 공간을 눌렀을 경우
//    case tapTrashTongButton                                 // 우측 상단 쓰레기통 버튼을 누른 경우
//    
//    case dismissImagePicker                                 // isShowingImagePicker 바인딩
//    case selectedImageChanged(UIImage?)                     // 이미지 피커에서 선택된 이미지 바인딩
//    
//    case updateItemInfoResponse(Result<UpdateItemInfoResponse, UpdateItemInfoError>)    // 제품 업데이트 API 호출의 결과
//    case deleteItemResponse(Result<DeleteItemResponse, DeleteItemError>)                // 제품 삭제 API 호출의 결과
//    
//    case dismissDeleteAlert                                 // isShowingAlert 바인딩
//    case deleteAlertOk                                      // Alert - 네 누른 경우
//    case deleteAlertCancel                                  // Alert - 아니오 누른 경우
//    
//    case dismissEditAlert                                   // isShowingEditAlert 바인딩
//    case EditAlertOk                                        // Alert - 네 누른 경우
//    case EditAlertCancel                                    // Alert - 아니오 누른 경우
//    
//    case dismissMaxLengthAlert                              // isShowingTitleMaxLengthAlert 바인딩
//    
//}
//
//// MARK: TCA - Environment
//struct EditItemDetailEnvironment {
//    let updateItemInfo: (UpdateItemInfoRequest) -> EffectPublisher<Result<UpdateItemInfoResponse, UpdateItemInfoError>, Never>
//    let deleteItem: (DeleteItemRequest) -> EffectPublisher<Result<DeleteItemResponse, DeleteItemError>, Never>
//}
//
//// MARK: TCA - Reducer
//let editItemDetailReducer = AnyReducer<EditItemDetailState, EditItemDetailAction, EditItemDetailEnvironment> { state, action, environment in
//    
//    switch action {
//    case let .nameChanged(name): // 이름 텍스트 필드 업데이트
//        state.name = name
//        
//        if state.name.count > 20 {
//            state.isShowingTitleMaxLengthAlert = true
//            state.name = ""
//        } else {
//            state.isShowingTitleMaxLengthAlert = false
//        }
//        return .none
//        
//    case let .priceChanged(price):                      // 가격 텍스트 필드 업데이트
//        state.price = price
//        return .none
//        
//    case let .discountChanged(discountedPrice):         // 할인 가격 텍스트 필드 업데이트
//        state.discountPrice = discountedPrice
//        return .none
//        
//    case let .countChanged(count):                      // 개수 텍스트 필드 업데이트
//        state.count = count
//        return .none
//        
//    case .tabImagePickerButton:                         // 이미지 피커를 누른 경우
//        state.isShowingImagePicker = true
//        return .none
//        
//    case .tabMinusButton:                               // 제품 개수 - 버튼 누른 경우
//        if state.count >= 1 { state.count -= 1 }
//        return .none
//        
//    case .tabPlusButton:                                // 제품 개수 + 버튼 누른 경우
//        state.count += 1
//        return .none
//        
//    case .tapBottomButton:                              // 하단 제품 등록 버튼을 누른 경우
//        state.isShowingEditAlert = true
//        return .none
//        
//    case .tapTrashTongButton:                           // 우측 상단 쓰레기통 버튼을 누른 경우
//        state.isShowingAlert = true
//        return .none
//        
//    case .tapEmptySpace:                                // 빈 공간을 눌렀을 경우
//        UIApplication.shared.sendAction(
//            #selector(UIResponder.resignFirstResponder),
//            to: nil,
//            from: nil,
//            for: nil
//        )
//        return .none
//        
//    case .dismissImagePicker:                           // isShowingImagePicker 바인딩
//        state.isShowingImagePicker = false
//        return .none
//        
//    case let .selectedImageChanged(image):              // 이미지 피커에서 선택된 이미지 바인딩
//        state.selectedImage = image
//        return .none
//        
//    // MARK: API 관련
//    case let .updateItemInfoResponse(.success(response)): // 제품 업데이트 API 호출 성공
//        state.isLoading = false
//        state.isPop = true
//        return .none
//        
//    case let .updateItemInfoResponse(.failure(error)):  // 제품 업데이트 API 호출 실패
//        switch error {
//        case .tokenExpired:
//            LoginManager.shared.setLoginOff()
//        default:
//            break
//        }
//        state.isLoading = false
//        return .none
//        
//    case let .deleteItemResponse(.success(response)):   // 제품 삭제 API 호출 성공
//        state.isLoading = false
//        state.isPop = true
//        return .none
//        
//    case let .deleteItemResponse(.failure(error)):      // 제품 삭제 API 호출 실패
//        switch error {
//        case .tokenExpired:
//            LoginManager.shared.setLoginOff()
//        default:
//            break
//        }
//        state.isLoading = false
//        return .none
//        
//    case .deleteAlertOk:                                // Alert - 삭제 누른 경우
//        state.isLoading = true
//        
//        let request = DeleteItemRequest(itemId: state.itemId)
//        
//        return environment.deleteItem(request)
//            .map(EditItemDetailAction.deleteItemResponse)
//            .eraseToEffect()
//        
//    case .deleteAlertCancel:                            // Alert - 취소 누른 경우
//        return .none
//        
//    case .dismissDeleteAlert:                           // isShowingAlert 바인딩
//        state.isShowingAlert = false
//        return .none
//        
//    case .dismissEditAlert:                             // isShowingEditAlert 바인딩
//        state.isShowingEditAlert = false
//        return .none
//        
//    case .EditAlertOk:                                  // Alert - 네 누른 경우
//        state.isLoading = true
//        
//        guard let itemPrice = Int(state.price) else { return .none }
//        guard let salePrice = Int(state.discountPrice) else { return .none }
//        
//        let items = UpdateItemInfoRequest.Item(
//            itemName: state.name,
//            imageUrl: state.imageUrl,
//            itemPrice: itemPrice,
//            salePrice: salePrice,
//            itemCount: state.count
//        )
//        
//        let request = UpdateItemInfoRequest(
//            itemid: state.itemId,
//            item: items,
//            image: state.selectedImage
//        )
//        
//        return environment.updateItemInfo(request)
//            .map(EditItemDetailAction.updateItemInfoResponse)
//            .eraseToEffect()
//        
//    case .EditAlertCancel:                              // Alert - 아니오 누른 경우
//        state.isShowingEditAlert = false
//        return .none
//        
//    case .dismissMaxLengthAlert:                        // 이름 최대 입력 개수 초과 Alert
//        state.isShowingTitleMaxLengthAlert = false
//        return .none
//        
//    case .tabClearButton:
//        state.name = ""
//        return .none
//    }
//}
