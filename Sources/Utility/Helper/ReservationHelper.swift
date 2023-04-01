//
//  ReservationHelper.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/01.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

class ReservationHelper {
    static func makeTotalPrice(reservation: Reservation) -> Int {
        
        var totalPrice: Int = 0

        for i in reservation.cartList.indices {
            let sumOfPrice = reservation.cartList[i].amount * reservation.cartList[i].salesPrice
            totalPrice += sumOfPrice
        }
        
        return totalPrice
    }
}
