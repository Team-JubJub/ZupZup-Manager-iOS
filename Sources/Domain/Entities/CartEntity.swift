//
//  CartEntity.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/19.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct CartEntity: Hashable, Equatable {
    var itemId: Int
    var amount: Int
    var name: String
    var price: Int
    var imageUrl: String
    var salePrice: Int
}

extension CartEntity {
    func toChangeStateOrder() -> ChangeStateRequest.Body.Order {
        return ChangeStateRequest.Body.Order(
            itemId: self.itemId,
            itemName: self.name,
            imageUrl: self.imageUrl,
            itemPrice: self.price,
            salePrice: self.salePrice,
            itemCount: self.amount
        )
    }
}
