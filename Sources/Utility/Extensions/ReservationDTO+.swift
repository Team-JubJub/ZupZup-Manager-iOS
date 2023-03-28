//
//  ReservationDTO+.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

extension ReservationDTO {
    func makeItemString() -> String {
        switch self.cartList.count {
        case 0:
            return ""
        case 1:
            return self.cartList[0].name + "\(self.cartList[0].amount)개"
        default:
            return self.cartList[0].name + " \(self.cartList[0].amount)개" + " 외 " + "\(cartList.count - 1)가지"
        }
    }
}
