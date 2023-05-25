//
//  ItemStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class ItemStore: ObservableObject {
    
    weak var manageStore: ManageStore?
    
    @Published var item: Item
    @Published var isShowingImagePicker: Bool = false
    @Published var selectedImage: UIImage?
    
    @Published var priceString: String
    @Published var discountString: String
    
    init(item: Item, manageStore: ManageStore) {
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
        }
    }
}

extension ItemStore {
    func tabImagePickerButton() {
        self.isShowingImagePicker = true
    }
    
    func tabTrashTong() {
        manageStore?.deleteItem(itemId: self.item.itemId)
    }
    
    func tabMinusButton() {
        self.item.amount -= 1
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
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
