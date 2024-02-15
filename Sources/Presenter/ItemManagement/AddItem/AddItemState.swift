//
//  AddItemStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//
//
import SwiftUI
import ComposableArchitecture

@Reducer
struct AddItem {
    
    @Dependency(\.addItemClient) var addItemClient
    
    struct State: Equatable {
        var count: Int = 0                                          // 제품 개수
        var name: String = ""                                       // 제품 이름
        var price: String = ""                                      // 제품 가격
        var discountPrice: String = ""                              // 재퓸 헐안 거굑
        var selectedImage: UIImage?                                 // 이미지 피커에서 선택된 이미니
        var isShowingImagePicker: Bool = false                      // 이미지 피커 트리거
        var isShowingAlert: Bool = false                            // 경고 창 트리거
        var isLoading: Bool = false                                 // 로딩 인디케이터 호출 변수
        var isShowingErrorAlert: Bool = false                       // 제품명 20자 제한
        var isPop: Bool = false                                     // 네비게이션 POP 변수
        var errorTitle: String = ""
        var errorMessage: String = ""
        
        @BindingState var pickerImage: UIImage?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case nameChanged(String)                                    // 제품 이름 텍스트 필드 업데이트
        case priceChanged(String)                                   // 제품 가격 텍스트 필드 업데이트
        case discountChanged(String)                                // 제품 할인 가격 텍스트 필드 업데이트
        case countChanged(Int)                                      // 제품 개수 텍스트 필드 업데이트
        case tabImagePickerButton                                   // 이미지 피커를 누른 경우
        case selectedImageChanged(UIImage?)                         // 이미지 피커에서 이미지를 선택한 경우
        case dismissImagePicker                                     // isShowingImagePicker 바인딩
        case tabMinusButton                                         // 제품 개수 + 버튼 누른 경우
        case tabPlusButton                                          // 제품 개수 - 버튼 누른 경우
        case tapBottomButton                                        // 하단 제품 등록 버튼을 누른 경우
        case tapEmptySpace                                          // 빈 공간을 눌렀을 경우
        case tabClearButton
        case dismissAlert                                           // isShowingAlert 바인딩
        case alertOkButton                                          // Alert - 네 누른 경우
        case alertCancelButton                                      // Alert - 아니오 누른 경우
        case dismissErrorAlert                                      // dismissErrorAlert 바인딩
        case tabErrorAlertOK
        case addItemResponse(Result<AddItemResponse, Error>) // 아이템 추가 API 호출의 결과
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case let .nameChanged(name):                                    // 이름 텍스트 필드 업데이트
                
                if name != state.name {
                    state.name = name
                    
                    if state.name.count <= 20 {
                        state.isShowingErrorAlert = false
                    } else {
                        state.errorTitle = "텍스트 초과"
                        state.errorMessage = "입력 가능한 제품명은 최대 20자 입니다."
                        state.isShowingErrorAlert = true
                        state.name = ""
                    }
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
                
                if state.name.isEmpty {
                    state.errorTitle = "제품의 이름이 없어요"
                    state.errorMessage = "제품의 이름을 등록해주세요!"
                    state.isShowingErrorAlert = true
                    state.isLoading = false
                    return .none
                }
                
                guard let image = state.selectedImage else {
                    state.errorTitle = "이미지가 없어요"
                    state.errorMessage = "제품의 이미지를 등록해주세요!"
                    state.isShowingErrorAlert = true
                    state.isLoading = false
                    return .none
                }
                
                guard let itemPrice = Int(state.price) else {
                    state.errorTitle = "가격이 비었어요"
                    state.errorMessage = "제품의 가격을 입력해주세요!"
                    state.isShowingErrorAlert = true
                    state.isLoading = false
                    return .none
                }
                
                guard let salePrice = Int(state.discountPrice) else {
                    state.errorTitle = "할인 가격이 비었어요"
                    state.errorMessage = "제품의 할인 가격을 입력해주세요!"
                    state.isShowingErrorAlert = true
                    state.isLoading = false
                    return .none
                }
                
                let items = AddItemRequest.Item(
                    itemName: state.name,
                    itemPrice: itemPrice,
                    salePrice: salePrice,
                    itemCount: state.count
                )
                
                let request = AddItemRequest(item: items, image: image)
                
                return .run { send in
                    await send (
                        .addItemResponse(Result {
                            try await self.addItemClient.addItem(request)
                        })
                    )
                }
            
            case let .addItemResponse(.success(response)):                  // 제품 추가 API의 Response
                state.isLoading = false
                state.isPop = true
                dump(response)
                return .none
                
            case let .addItemResponse(.failure(error)):                     // 제품 추가 API의 Response
                state.isLoading = false
                // TODO: Error Handling
                //            switch error {
                //            case .tokenExpired:
                //                LoginManager.shared.setLoginOff()
                //            default:
                //                break
                //            }
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
                
            case .dismissErrorAlert:
                state.isShowingErrorAlert = false
                return .none
                
            case .tabClearButton:
                state.name = ""
                return .none
                
            case .tabErrorAlertOK:
                state.isShowingAlert = false
                return .none
                
            case .binding(\.$pickerImage):
                state.selectedImage = state.pickerImage
                return .none
                
            case .binding:
                return .none
            }
        }
    }
}

struct AddItemClient {
    var addItem: (AddItemRequest) async throws -> AddItemResponse
}

extension AddItemClient: DependencyKey {
    static var liveValue = AddItemClient(
        addItem: { request in
            let response = try await AddItemRepositoryImpl().addItem(request: request)
            return response
        }
    )
}

extension DependencyValues {
    var addItemClient: AddItemClient {
        get { self[AddItemClient.self] }
        set { self[AddItemClient.self] = newValue }
    }
}
