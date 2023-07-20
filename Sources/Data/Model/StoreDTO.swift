//
//  StoreDTO.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import FirebaseFirestoreSwift

public struct StoreDTO: Codable {
    @DocumentID var id: String?
    public var address: String
    public var eventList: [String]
    public var hostPhoneNumber: String
    public var latitude: Double
    public var longitude: Double
    public var merchandiseList: [Merchandise]
    public var name: String
    public var openTime: String
    public var saleTimeEnd: Int
    public var saleTimeStart: Int
    public var storeId: Int
    
    public struct Merchandise: Codable {
        public var discounted: Int
        public var imgUrl: String
        public var itemId: Int
        public var itemName: String
        public var price: Int
        public var stock: Int
        public var storeId: Int
    }
}

extension StoreDTO.Merchandise {
    func toItem() -> ItemEntity {
        return ItemEntity(
            itemId: self.itemId,
            name: self.itemName,
            priceOrigin: self.price,
            priceDiscount: self.discounted,
            amount: self.stock,
            imageUrl: self.imgUrl
        )
    }
}

extension StoreDTO {
    func toStore() -> StoreEntity {
        return StoreEntity(
            name: self.name,
            time: self.openTime,
            event: self.eventList[0],
            discountTime: self.saleTimeStart.toString(),
            items: self.merchandiseList.map { $0.toItem() }
        )
    }
}
