//
//  EditStoreInfoStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/13.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct EditStoreInfoState: Equatable {
    
    init(storeEntity: StoreEntity) {
        self.daysOfWeek = storeEntity.closedDay
        (self.openTime, self.openMinute) = splitTime(storeEntity.openTime)
        (self.closeTime, self.closeMinute) = splitTime(storeEntity.closeTime)
        (self.discountStartTime, self.discountStartMinute) = splitTime(storeEntity.saleStartTime)
        (self.discountEndTime, self.discountEndMinute) = splitTime(storeEntity.saleEndTime)
    }
    
    var isShowingImagePicker = false // 이미지 피커 상태 변수
    var selectedImage: UIImage? // 이미지 피커에서 선택된 이미지 변수
    
    var isShowingOpenTimePicker: Bool = false
    var openTime: String // 영업 시작 시간 (시)
    var openMinute: String // 영업 시작 시간 (분)
    
    var isShowingCloseTimePicker: Bool = false
    var closeTime: String // 영업 종료 시간 (시)
    var closeMinute: String // 영업 종료 시간 (분)
    
    var isShowingDiscountStartTimePicker: Bool = false
    var discountStartTime: String // 할인 시작 시간 (시)
    var discountStartMinute: String // 할인 시작 시간 (분)
    
    var isShowingDiscountEndTimePicker: Bool = false
    var discountEndTime: String // 할인 종료 시간 (시)
    var discountEndMinute: String // 할인 종료 시간 (분)
    
    var daysOfWeek: [Bool]
}

enum EditStoreInfoAction: Equatable {
    
    case tapOpenStartTime // 영업 시간 시작 버튼을 눌렀을 경우
    case tapOpenEndTime // 영업 시간 종료 버튼을 눌렀을 경우
    case tapDiscountStartTime // 마감 할인 시작 시간을 눌렀을 경우
    case tapDiscountEndTime // 마감 할인 시작 시간을 눌렀을 경우
    
    case tapBottomButton // 수정 완료 버튼을 눌렀을 경우
    case tapDaysButton(Int) // 요일 버튼을 눌렀을 경우
    case daysOfWeekBinding // 휴무일 바인딩
    
    case tapImagePicker // 이미지 피커를 눌렀을 경우
    case selectedImageChanged(UIImage?) // 이미지 피커에서 선택된 이미지 바인딩
    case dismissImagePicker // isShowingImagePicker변수 바인딩
    
    case opneTimeChanged(String) // 영업 시작(시간) 바인딩
    case openMinuteChanged(String) // 영업 시작(분) 바인딩
    
    case closeTimeChanged(String) // 영업 종료(시간) 바인딘
    case closeMinuteChanged(String) // 영업 종료(분) 바인딩
    
    case discountStartTimeChanged(String) // 마감 할인 시작(시간) 바인딩
    case discountStartMinuteChanged(String) // 마감 할인 시작(분) 바인딩
    
    case discountEndTimeChanged(String) // 마감 할인 종료(시간) 바인딩
    case discountEndMinuteChanged(String) // 마감 할인 종료(분) 바인딩
    
    case dismissOpenTimePicker
    case dismissCloseTimePicker
    case dismissDiscountStartTimePicker
    case dismissDiscountEndTimePicker
    
}

struct EditStoreInfoEnvironment {
    
}

let editStoreInfoReducer = AnyReducer<EditStoreInfoState, EditStoreInfoAction, EditStoreInfoEnvironment> { state, action, environment in
    
    switch action {
    case .tapImagePicker: // 이미지 피커를 눌렀을 경우
        state.isShowingImagePicker = true
        return .none
        
    case .tapOpenStartTime: // 영업 시간 시작 버튼을 눌렀을 경우
        state.isShowingCloseTimePicker = false
        if !state.isShowingCloseTimePicker {
            state.isShowingOpenTimePicker.toggle()
        }
        return .none
        
    case .tapOpenEndTime: // 영업 시간 종료 버튼을 눌렀을 경우
        state.isShowingOpenTimePicker = false
        if !state.isShowingOpenTimePicker {
            state.isShowingCloseTimePicker.toggle()
        }
        return .none
        
    case .tapDiscountStartTime: // 마감 할인 시작 시간을 눌렀을 경우
        state.isShowingDiscountEndTimePicker = false
        if !state.isShowingDiscountEndTimePicker {
            state.isShowingDiscountStartTimePicker.toggle()
        }
        return .none
        
    case .tapDiscountEndTime: // 마감 할인 시작 시간을 눌렀을 경우
        state.isShowingDiscountStartTimePicker = false
        if !state.isShowingDiscountStartTimePicker {
            state.isShowingDiscountEndTimePicker.toggle()
        }
        return .none
        
    case .tapBottomButton: // 수정 완료 버튼을 눌렀을 경우
        // TODO: 통신 - 수정 완료
        return .none
        
    case let .tapDaysButton(idx): // 요일 버튼을 눌렀을 경우
        state.daysOfWeek[idx].toggle()
        return .none
        
    case let .selectedImageChanged(image): // SelectedImage 바인딩
        state.selectedImage = image
        return .none
        
    case .dismissImagePicker:
        state.isShowingImagePicker = false
        return .none
        
    case let .opneTimeChanged(time): // 영업 시작(시간) 바인딩
        state.openTime = time
        return .none
        
    case let .openMinuteChanged(minute): // 영업 시작(분) 바인딩
        state.openMinute = minute
        return .none
        
    case let .closeTimeChanged(time): // 영업 종료(시간) 바인딘
        state.closeTime = time
        return .none
        
    case let .closeMinuteChanged(minute): // 영업 종료(분) 바인딩
        state.closeMinute = minute
        return .none
        
    case let .discountStartTimeChanged(time): // 마감 할인 시작(시간) 바인딩
        state.discountStartTime = time
        return .none
        
    case let .discountStartMinuteChanged(minute): // 마감 할인 시작(분) 바인딩
        state.discountStartMinute = minute
        return .none
        
    case let .discountEndTimeChanged(time): // 마감 할인 종료(시간) 바인딩
        state.discountEndTime = time
        return .none
            
    case let .discountEndMinuteChanged(minute): // 마감 할인 종료(분) 바인딩
        state.discountEndMinute = minute
        return .none
        
    case .dismissOpenTimePicker:
        state.isShowingOpenTimePicker = false
        return .none
        
    case .dismissCloseTimePicker:
        state.isShowingCloseTimePicker = false
        return .none
        
    case .dismissDiscountStartTimePicker:
        state.isShowingDiscountStartTimePicker = false
        return .none
        
    case .dismissDiscountEndTimePicker:
        state.isShowingDiscountEndTimePicker = false
        return .none
        
    case .daysOfWeekBinding:
        return .none
    }
}
