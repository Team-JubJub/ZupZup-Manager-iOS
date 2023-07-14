//
//  Store.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct StoreEntity: Equatable {
    var name: String = ""
    var time: String = ""
    var event: String = ""
    var discountTime: String = ""
    var items: [ItemEntity] = []
}
