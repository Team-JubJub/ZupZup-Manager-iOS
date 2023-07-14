//
//  StoreManagementStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/04.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class StoreManagementStore: ObservableObject {
    
    @Published var isToggleOn = false
    @Published var isShowingEditStoreInfo = false
}

extension StoreManagementStore: StoreProtocol {
    enum Action {
        case tapToggle
        case tapInfoButton
    }
    
    func reduce(action: Action) {
        switch action {
        case .tapToggle:
            self.tapToggle()
        case .tapInfoButton:
            self.tapInfoButton()
        }
    }
}

extension StoreManagementStore {
    private func tapToggle() {
        
    }
    
    private func tapInfoButton() {
        self.isShowingEditStoreInfo = true
    }
}
