//
//  FetchItemsResponse.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

typealias FetchItemsResponse = [FetchItemsDTO.Item]

struct FetchItemsDTO: Decodable {
    struct Item: Decodable {
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
                amount: self.itemCount,
                imageUrl: self.imageURL ?? ""
            )
        }
    }
}
