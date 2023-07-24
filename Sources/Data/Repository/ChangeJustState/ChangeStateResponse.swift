//
//  ChangeStateResponse.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct ChangeStateResponse: Decodable, Equatable {
    let data: Reservation
    let message: String
    
    struct Reservation: Decodable, Equatable {
        let orderId: Int
        let storeId: Int
        let userId: Int
        let orderStatus: String
        let userName: String
        let phoneNumber: String
        let orderTitle: String
        let orderTime: String
        let visitTime: String
        let storeName: String
        let storeAddress: String
        let category: String
        let orderList: [Order]
        
        struct Order: Decodable, Equatable {
            let itemId: Int
            let itemName: String
            let itemPrice: Int
            let itemCount: Int
        }
    }
    
    func toCondition() -> ReservationCondition {
        switch self.data.orderStatus {
        case "NEW":
            return .new
        case "CONFIRM":
            return .confirm
        case "CANCEL":
            return .cancel
        default:
            return .complete
        }
    }
}
