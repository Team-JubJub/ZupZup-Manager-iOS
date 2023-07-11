//
//  ItemStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class EditItemInfoStore: ObservableObject {
    
    @Environment(\.dismiss) private var dismiss
    
    @Published var items: [Item]
    
    @Published var isShowDetail: Bool = false
    
    init(items: [Item]) {
        self.items = items
    }
}

extension EditItemInfoStore: StoreProtocol {
    enum Action {
        case tapGridItem
        case tapBottomButton
    }
    
    func reduce(action: Action) {
        switch action {
        case .tapGridItem:
            self.tapGridItem()
        case .tapBottomButton:
            self.tapBottomButton()
        }
    }
}

extension EditItemInfoStore {
    func tapGridItem() {
        self.isShowDetail = true
    }
    
    func tapBottomButton() {
        dismiss()
    }
}
