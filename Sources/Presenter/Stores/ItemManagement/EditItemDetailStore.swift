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
    
    @Published var item: Item
    
    @Published var count: Int = 0
    @Published var selectedImage: UIImage?
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var discountPrice: String = ""
    @Published var isShowingImagePicker: Bool = false
    @Published var isShowingAlert: Bool = false
    
    init(item: Item) {
        self.item = item
    }
}

extension EditItemDetailStore: StoreProtocol {
    enum Action {
        case tabImagePickerButton
        case tabMinusButton
        case tabPlusButton
        case tabBottomButton
        case alertOkButton
        case alertCancelButton
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
        case .alertOkButton:
            self.tabAlertOkButton()
        case .alertCancelButton:
            self.tabAlertCancelButton()
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
        self.isShowingAlert = true
    }
    
    func tabAlertOkButton() {
    }
    
    func tabAlertCancelButton() {
        self.isShowingAlert = false
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
