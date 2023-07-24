//
//  Item.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/29.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct ItemEntity: Hashable, Equatable {
    var itemId: Int
    var name: String
    var priceOrigin: Int
    var priceDiscount: Int
    var count: Int
    var imageUrl: String
}
