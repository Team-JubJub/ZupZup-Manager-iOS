//
//  UpdateItemCountRequest.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct UpdateItemCountRequest: Encodable, Equatable {
    let quantity: [Quantity]
    
    struct Quantity: Codable, Equatable {
        let itemId: Int
        let itemCount: Int
    }
}
