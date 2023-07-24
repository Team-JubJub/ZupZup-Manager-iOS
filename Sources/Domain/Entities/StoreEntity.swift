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
    var imageUrl: String = ""
    var address: String = ""
    var category: String = ""
    var contact: String = ""
    var latitude: Float = 0
    var longitude: Float = 0
    var openTime: String = ""
    var closeTime: String = ""
    var saleStartTime: String = ""
    var saleEndTime: String = ""
    var announcement: String = ""
    var isOpen: Bool = false
    var closedDay: [Bool] = []
}
