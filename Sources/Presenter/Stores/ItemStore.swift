//
//  ItemStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class ItemStore: ObservableObject {
    
    weak var manageStore: ItemManageStore?
    
    @Published var item: Item
    
    @Published var isShowingImagePicker: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var isShowingEmptyAlert: Bool = false
    
    @Published var selectedImage: UIImage?
    
    @Published var priceString: String
    @Published var discountString: String
    
    init(item: Item, manageStore: ItemManageStore) {
        self.item = item
        self.priceString = item.priceOrigin.toString()
        self.discountString = item.priceDiscount.toString()
        self.manageStore = manageStore
    }
}

extension ItemStore: StoreProtocol {
    enum Action {
        case tabImagePickerButton
        case tabTrashTong
        case tabMinusButton
        case tabPlusButton
        case tabBottomButton
        case tabAlertDelete
        case tabAlertCancel
        case checkTextfieldEmpty
    }
    
    func reduce(action: Action) {
        switch action {
        case .tabImagePickerButton:
            self.tabImagePickerButton()
        case .tabTrashTong:
            self.tabTrashTong()
        case .tabMinusButton:
            self.tabMinusButton()
        case .tabPlusButton:
            self.tabPlusButton()
        case .tabBottomButton:
            self.tabBottomButton()
        case .tabAlertDelete:
            self.tabAlertDelete()
        case .tabAlertCancel:
            self.tabAlertCancel()
        case .checkTextfieldEmpty:
            self.checkTextfieldEmpty()
        }
    }
}

extension ItemStore {
    func tabImagePickerButton() {
        self.isShowingImagePicker = true
    }
    
    func tabTrashTong() {
        self.isShowingAlert = true
    }
    
    func tabAlertDelete() {
        manageStore?.deleteItem(itemId: self.item.itemId)
    }
    
    func tabAlertCancel() {
        self.isShowingAlert = false
    }
    
    func tabMinusButton() {
        if self.item.amount > 0 { self.item.amount -= 1 }
    }
    
    func tabPlusButton() {
        self.item.amount += 1
    }
    
    func tabBottomButton() {
        guard let priceOrigin = Int(priceString) else { return }
        guard let priceDiscount = Int(discountString) else { return }
        self.item.priceOrigin = priceOrigin
        self.item.priceDiscount = priceDiscount
        
        manageStore?.updateItem(newItem: self.item)
    }
    
    func checkTextfieldEmpty() {
        if item.name.isEmpty {
            self.isShowingEmptyAlert = true
        } else {
            self.isShowingEmptyAlert = false
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
