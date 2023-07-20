//
//  CartEntity.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/19.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct CartEntity: Hashable, Equatable {
    var itemId: Int
    var amount: Int
    var name: String
    var price: Int
}
