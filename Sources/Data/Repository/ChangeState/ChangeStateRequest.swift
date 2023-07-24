//
//  ChangeStateRequest.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct ChangeStateRequest: Encodable, Equatable {
    
    let orderId: Int
    let state: State
    let body: Body
    
    struct Body: Encodable, Equatable {
        let orderList: [Order]
        
        struct Order: Encodable, Equatable {
            let itemId: Int
            let itemName: String
            let itemPrice: Int
            let itemCount: Int
        }
    }
    
    enum State: Encodable, Equatable {
        case cancel
        case confirm
    }
}
