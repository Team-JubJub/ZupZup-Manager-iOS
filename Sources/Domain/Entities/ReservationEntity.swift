//
//  Reservation.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct ReservationEntity: Hashable, Equatable {
    var id: Int
    var customerName: String
    var phoneNumber: String
    var state: ReservationCondition
    var storeId: Int
    var visitTime: String
    var cartList: [CartEntity]
    var orderedItemdName: String
    var orderedTime: String
}

extension ReservationEntity {
    func toChangeStateRequest(state: ReservationCondition) -> ChangeStateRequest {
        return ChangeStateRequest(
            orderId: self.id,
            state: state.toChangeStateCondition(),
            body: self.toChangeStateBody()
        )
    }
    
    func toChangeStateBody() -> ChangeStateRequest.Body {
        return ChangeStateRequest.Body(
            orderList: self.cartList.map { $0.toChangeStateOrder() }
        )
    }
    
    func toJustChangeStateRequest(state: ReservationCondition) -> ChangeJustStateRequest {
        return ChangeJustStateRequest(
            orderId: self.id,
            state: state.toJustChangeStateCondition()
        )
    }
}
