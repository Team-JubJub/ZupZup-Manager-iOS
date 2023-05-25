//
//  AddItemStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class AddItemStore: ObservableObject {
    
    weak var manageStore: ManageStore?
    
    private let itemId: Int
    @Published var name: String = ""
    @Published var selectedImage: UIImage?
    @Published var priceString: String = "0"
    @Published var discountString: String = "0"
    @Published var isShowingImagePicker: Bool = false
    @Published var count: Int = 0
    
    init(itemId: Int, manageStore: ManageStore) {
        self.itemId = itemId
        self.manageStore = manageStore
    }
}

extension AddItemStore: StoreProtocol {
    enum Action {
        case tabImagePickerButton
        case tabMinusButton
        case tabPlusButton
        case tabBottomButton
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
        }
    }
}

extension AddItemStore {
    func tabImagePickerButton() {
        self.isShowingImagePicker = true
    }
    
    func tabMinusButton() {
        self.count -= 1
    }
    
    func tabPlusButton() {
        self.count += 1
    }
    
    func tabBottomButton() {
        guard let priceOrigin = Int(priceString) else { return }
        guard let priceDiscount = Int(discountString) else { return }
        
        let item = Item(
            itemId: self.itemId,
            name: self.name,
            priceOrigin: priceOrigin,
            priceDiscount: priceDiscount,
            amount: self.count,
            imageUrl: "",
            storeId: 9
        )
        
        manageStore?.appendItem(item: item)
        
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
