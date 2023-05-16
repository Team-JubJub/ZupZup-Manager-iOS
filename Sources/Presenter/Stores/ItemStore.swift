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
    
    init(item: Item) {
        self.item = item
    }
}
