//
//  CancelConfirmedOrderDTO.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/21/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

struct CancelConfirmedOrderDTO: Encodable, Equatable {
    let orderList: [Order]
    
    struct Order: Encodable, Equatable {
        let itemId: Int
        let itemName: String
        let imageUrl: String
        let itemPrice: Int
        let salePrice: Int
        let itemCount: Int
    }
}
