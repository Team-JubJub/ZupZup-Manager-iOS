//
//  FetchStoreResponse.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/19.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct FetchReservationsResponse: Codable {
    let orderList: [Order]
    
    struct Order: Codable {
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
        let orderList: [Item]
    }
    
    struct Item: Codable {
        let itemId: Int
        let itemName: String
        let itemPrice: Int
        let itemCount: Int
    }
}

extension FetchReservationsResponse {
    
    func toReservations() -> [ReservationEntity] {
        return self.orderList.map { order in
            ReservationEntity(
                id: order.orderId.toString(),
                customerName: order.userName,
                phoneNumber: order.phoneNumber,
                state: order.orderStatus.toReservationState,
                storeId: order.storeId,
                date: order.visitTime,
                cartList: order.orderList.map { $0.toCart() },
                orderedItemdName: order.orderTitle,
                orderedTime: order.orderTime
            )
        }
    }
}

extension FetchReservationsResponse.Item {
    func toCart() -> CartEntity {
        return CartEntity(
            itemId: self.itemId,
            amount: self.itemCount,
            name: self.itemName,
            price: self.itemPrice
        )
    }
}
