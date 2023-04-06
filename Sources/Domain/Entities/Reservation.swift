//
//  Reservation.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct Reservation: Hashable {
    var id: String
    var customerName: String
    var phoneNumber: String
    var state: ReservationState
    var storeId: Int
    var date: String
    var cartList: [ReservationDTO.CartDTO]
    var orderedItemdName: String
    var orderedTime: String
}
