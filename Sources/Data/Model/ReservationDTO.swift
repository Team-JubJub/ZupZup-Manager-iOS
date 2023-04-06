//
//  Reservation.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct ReservationDTO: Codable, Equatable, Hashable {
    var customerName: String
    var customerPhone: String
    var state: String
    var storeId: Int
    var visitTime: Int
    var reserveId: Int
    var cartList: [CartDTO]
    
    struct CartDTO: Codable, Equatable, Hashable {
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
         cartList: [CartDTO]
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

// Entity로 변환하는 코드 DTO -> Entity
extension ReservationDTO {
    func toReservation() -> Reservation {
        return Reservation(
            id: self.reserveId.toString(),
            customerName: self.customerName,
            phoneNumber: self.customerPhone,
            state: self.state.toReservationState,
            storeId: self.storeId,
            date: self.reserveId.dateFromMilliseconds(),
            cartList: self.cartList,
            orderedItemdName: self.makeItemString(),
            orderedTime: self.visitTime.makeDiscountTime()
        )
    }
}
