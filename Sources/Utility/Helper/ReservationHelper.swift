//
//  ReservationHelper.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/01.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

class ReservationHelper {
    static func makeTotalPrice(reservation: ReservationEntity) -> Int {
        
        var totalPrice: Int = 0

        for i in reservation.cartList.indices {
            let sumOfPrice = reservation.cartList[i].amount * reservation.cartList[i].price
            totalPrice += sumOfPrice
        }
        
        return totalPrice
    }
    
    static func twentyMinutePlus(reservation: ReservationEntity) -> String {
        
        let origin = reservation.orderedTime.filter { $0.isNumber }
        
        guard let originToInt = Int(origin) else { return "" }
        
        let originPlusTwenty = originToInt + 20
        
        return originToInt.makeDiscountTime() + " ~ " + originPlusTwenty.makeDiscountTime()
    }
}
