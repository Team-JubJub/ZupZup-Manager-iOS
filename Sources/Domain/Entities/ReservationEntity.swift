//
//  Reservation.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct ReservationEntity: Hashable, Equatable {
    var id: String
    var customerName: String
    var phoneNumber: String
    var state: ReservationCondition
    var storeId: Int
    var date: String
    var cartList: [CartEntity]
    var orderedItemdName: String
    var orderedTime: String
}
