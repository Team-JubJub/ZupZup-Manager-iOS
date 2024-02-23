//
//  GetAllItemsResponse.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/22/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

typealias GetAllItemsResponse = [GetAllItemsDTO.Item]

struct GetAllItemsDTO: Codable {
    struct Item: Codable {
        let itemId: Int
        let itemName: String
        let imageURL: String?
        let itemPrice: Int
        let salePrice: Int
        let itemCount: Int
        
        func toItem() -> ItemEntity {
            return ItemEntity(
                itemId: self.itemId,
                name: self.itemName,
                priceOrigin: self.itemPrice,
                priceDiscount: self.salePrice,
                count: self.itemCount,
                imageUrl: self.imageURL ?? ""
            )
        }
    }
}
