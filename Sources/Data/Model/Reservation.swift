//
//  Reservation.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct Reservation: Codable, Equatable {
    var customerName: String
    var customerPhone: String
    var state: String
    var storeId: Int
    var visitTime: Int
    var reserveId: Int
    var cartList: [Cart]
    
    struct Cart: Codable, Equatable {
        var itemId: Int
        var storeId: Int
        var amount: Int
        var name: String
        var salesPrice: Int
        
        init(
            itemId: Int,
            storeId: Int,
            amount: Int,
            name: String,
            salesPrice: Int
        ) {
            self.itemId = itemId
            self.storeId = storeId
            self.amount = amount
            self.name = name
            self.salesPrice = salesPrice
        }
    }
    
    init(
         customerName: String,
         customerPhone: String,
         state: String,
         storeId: Int,
         visitTime: Int,
         reserveId: Int,
         cartList: [Cart]
    ) {
        self.customerName = customerName
        self.customerPhone = customerPhone
        self.state = state
        self.storeId = storeId
        self.visitTime = visitTime
        self.reserveId = reserveId
        self.cartList = cartList
    }
}

typealias Reservations = [Reservation]
