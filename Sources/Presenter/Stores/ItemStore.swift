//
//  ItemStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class ItemStore: ObservableObject {
    
    @Published var item: Item
    @Published var isShowingImagePicker: Bool = false
    @Published var selectedImage: UIImage?
    
    init(item: Item) {
        self.item = item
    }
}

extension ItemStore: StoreProtocol {
    enum Action {
        case tabImagePickerButton
        case tabTrashTong
        case tabMinusButton
        case tabPlusButton
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
        }
    }
}

extension ItemStore {
    func tabImagePickerButton() {
        self.isShowingImagePicker = true
    }
    
    func tabTrashTong() {
        
    }
    
    func tabMinusButton() {
        
    }
    
    func tabPlusButton() {
        
    }
}
