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
}

extension EditStoreInfoStore: StoreProtocol {
    enum Action {
        case tapImagePicker // 이미지 피커를 눌렀을 경우
        case tapOpenTimeStart // 영업 시간 시작 버튼을 눌렀을 경우
        case tapOpenTimeEnd // 영업 시간 종료 버튼을 눌렀을 경우
    }
    
    func reduce(action: Action) {
        switch action {
        case .tapImagePicker:
            self.tapImagePicker()
        case .tapOpenTimeStart:
            self.tapOpenTimeStart()
        case .tapOpenTimeEnd:
            self.tapOpenTimeEnd()
        }
    }
}

extension EditStoreInfoStore {
    private func tapImagePicker() {
        self.isShowingImagePicker = true
    }
    
    private func tapOpenTimeStart() {
        withAnimation {
            self.isShowingOpenTimePicker.toggle()
        }
    }
    
    private func tapOpenTimeEnd() {
        withAnimation {
            self.isShowingOpenTimePicker.toggle()
        }
    }
}
