//
//  EditStoreInfoStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/13.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class EditStoreInfoStore: ObservableObject {
    
    @Published var isShowingImagePicker = false // 이미지 피커 상태 변수
    @Published var selectedImage: UIImage? // 이미지 피커에서 선택된 이미지 변수
    
    @Published var isShowingOpenTimePicker: Bool = false
    @Published var openTime: String = "09" // 영업 시작 시간 (시)
    @Published var openMinute: String = "10" // 영업 시작 시간 (분)
    
    @Published var isShowingCloseTimePicker: Bool = false
    @Published var closeTime: String = "21" // 영업 종료 시간 (시)
    @Published var closeMinute: String = "10" // 영업 종료 시간 (분)
    
    @Published var isShowingDiscountStartTimePicker: Bool = false
    @Published var discountStartTime: String = "09" // 할인 시작 시간 (시)
    @Published var discountStartMinute: String = "15" // 할인 시작 시간 (분)
    
    @Published var isShowingDiscountEndTimePicker: Bool = false
    @Published var discountEndTime: String = "21" // 할인 종료 시간 (시)
    @Published var discountEndMinute: String = "00" // 할인 종료 시간 (분)
    
    @Published var daysOfWeek: [Bool] = [ true, false, false, false, false, false, false ]
}

extension EditStoreInfoStore: StoreProtocol {
    enum Action {
        case tapImagePicker // 이미지 피커를 눌렀을 경우
        case tapOpenStartTime // 영업 시간 시작 버튼을 눌렀을 경우
        case tapOpenEndTime // 영업 시간 종료 버튼을 눌렀을 경우
        case tapDiscountStartTime // 마감 할인 시작 시간을 눌렀을 경우
        case tapDiscountEndTime // 마감 할인 시작 시간을 눌렀을 경우
        case tapBottomButton // 수정 완료 버튼을 눌렀을 경우
        case tapDaysButton // 요일 버튼을 눌렀을 경우
    }
    
    func reduce(action: Action) {
        switch action {
        case .tapImagePicker:
            self.tapImagePicker()
        case .tapOpenStartTime:
            self.tapOpenTimeStart()
        case .tapOpenEndTime:
            self.tapOpenTimeEnd()
        case .tapDiscountStartTime:
            self.tapDiscountStartTime()
        case .tapDiscountEndTime:
            self.tapDiscountEndTime()
        case .tapBottomButton:
            self.tapBottomButton()
        default:
            break
        }
    }
    
    func reduce(action: Action, idx: Int) {
        switch action {
        case .tapDaysButton:
            self.tapDaysButton(idx: idx)
        default:
            break
        }
    }
}

extension EditStoreInfoStore {
    private func tapImagePicker() {
        self.isShowingImagePicker = true
    }
    
    private func tapOpenTimeStart() {
        self.isShowingCloseTimePicker = false
        if !isShowingCloseTimePicker {
            withAnimation {
                self.isShowingOpenTimePicker.toggle()
            }
        }
    }
    
    private func tapOpenTimeEnd() {
        self.isShowingOpenTimePicker = false
        if !isShowingOpenTimePicker {
            withAnimation {
                self.isShowingCloseTimePicker.toggle()
            }
        }
    }
    
    private func tapDiscountStartTime() {
        self.isShowingDiscountEndTimePicker = false
        if !isShowingDiscountEndTimePicker {
            withAnimation {
                self.isShowingDiscountStartTimePicker.toggle()
            }
        }
    }
    
    private func tapDiscountEndTime() {
        self.isShowingDiscountStartTimePicker = false
        if !isShowingDiscountStartTimePicker {
            withAnimation {
                self.isShowingDiscountEndTimePicker.toggle()
            }
        }
    }
    
    private func tapBottomButton() {
        // TODO: 통신 - 수정 완료
    }
    
    private func tapDaysButton(idx: Int) {
        self.daysOfWeek[idx].toggle()
    }
}
