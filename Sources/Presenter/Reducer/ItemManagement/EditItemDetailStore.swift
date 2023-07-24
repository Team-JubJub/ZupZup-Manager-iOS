//
//  EditItemDetailStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/11.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct EditItemDetailState: Equatable {
    let imageUrl: String
    var count: Int // 제품 개수
    var selectedImage: UIImage? // 이미지 피커에서 선택된 이미니
    var name: String // 제품 이름
    var price: String // 제품 가격
    var discountPrice: String // 재퓸 헐안 거굑
    var isShowingImagePicker: Bool = false // 이미지 피커 트리거
    var isShowingAlert: Bool = false // 경고 창 트리거
}

enum EditItemDetailAction: Equatable {
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
    case tapTrashTongButton // 우측 상단 쓰레기통 버튼을 누른 경우
    case dismissAlert // isShowingAlert 바인딩
    case dismissImagePicker // isShowingImagePicker 바인딩
    case selectedImageChanged(UIImage?) // 이미지 피커에서 선택된 이미지 바인딩
}

struct EditItemDetailEnvironment {
    
}

let editItemDetailReducer = AnyReducer<EditItemDetailState, EditItemDetailAction, EditItemDetailEnvironment> { state, action, environment in
    
    return .none
}
