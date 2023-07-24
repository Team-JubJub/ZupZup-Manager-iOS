//
//  FetchStoreResponse.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct FetchStoreResponse: Decodable {
    let storeId: Int
    let sellerId: Int
    let storeName: String
    let storeImageUrl: String?
    let storeAddress: String
    let category: String
    let contact: String
    let longitude: Float
    let latitude: Float
    let openTime: String
    let closeTime: String
    let saleTimeStart: String
    let saleTimeEnd: String
    let saleMatters: String
    let isOpen: Bool
    let closedDay: String?
}

extension FetchStoreResponse {
    func toStoreEntity() -> StoreEntity {
        return StoreEntity(
            name: self.storeName,
            imageUrl: self.storeImageUrl ?? "",
            address: self.storeAddress,
            category: self.category,
            contact: self.contact,
            latitude: self.latitude,
            longitude: self.longitude,
            openTime: self.openTime,
            closeTime: self.closeTime,
            saleStartTime: self.saleTimeStart,
            saleEndTime: self.saleTimeEnd,
            announcement: self.saleMatters,
            isOpen: self.isOpen,
            closedDay: []
        )
    }
}
