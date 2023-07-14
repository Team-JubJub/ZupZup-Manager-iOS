//
//  EditItemDetailStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/11.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class EditItemDetailStore: ObservableObject {
    
    @Environment(\.dismiss) private var dismiss
    
    let imageUrl: String // 아이템이 이미 가지고 있던 이미지 URL
    
    @Published var selectedImage: UIImage? // 이미지 피커로 선택한 이미지를 담을 변수
    @Published var name: String = ""
    @Published var priceOrigin: String = ""
    @Published var priceDiscount: String = ""
    @Published var count: Int = 0
    
    @Published var isShowingImagePicker: Bool = false
    @Published var isShowingAlert: Bool = false
    
    init(item: ItemEntity) {
        self.imageUrl = item.imageUrl
        self.count = item.amount
        self.name = item.name
        self.priceOrigin = item.priceOrigin.toString()
        self.priceDiscount = item.priceDiscount.toString()
    }
}

extension EditItemDetailStore: StoreProtocol {
    enum Action {
        case tabImagePickerButton
        case tabMinusButton
        case tabPlusButton
        case tabBottomButton
        case tapTrashTongButton
        case tapAlertCancel
        case tapAlertDelete
    }
    
    func reduce(action: Action) {
        switch action {
        case .tabImagePickerButton:
            self.tabImagePickerButton()
        case .tabMinusButton:
            self.tabMinusButton()
        case .tabPlusButton:
            self.tabPlusButton()
        case .tabBottomButton:
            self.tabBottomButton()
        case .tapTrashTongButton:
            self.tapTrashTongButton()
        case .tapAlertCancel:
            self.tapAlertCancel()
        case .tapAlertDelete:
            self.tapAlertDelete()
        }
    }
}

extension EditItemDetailStore {
    func tabImagePickerButton() {
        self.isShowingImagePicker = true
    }
    
    func tabMinusButton() {
        if self.count >= 1 { self.count -= 1 }
    }
    
    func tabPlusButton() {
        self.count += 1
    }
    
    func tabBottomButton() {
        
    }
    
    func tapAlertCancel() {
        self.isShowingAlert = false
    }
    
    func tapTrashTongButton() {
        self.isShowingAlert = true
    }
    
    func tapAlertDelete() {
        
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
