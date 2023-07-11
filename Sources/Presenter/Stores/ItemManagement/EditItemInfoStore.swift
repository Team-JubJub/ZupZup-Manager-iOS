//
//  ItemStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class EditItemInfoStore: ObservableObject {
    @Published var items: [Item]
    
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
        
    }
    
    func tapBottomButton() {
        
    }
}
