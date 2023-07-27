//
//  EditStoreInfoRequest.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct EditStoreInfoRequest: Equatable {
    let data: StoreInfo
    let image: UIImage
    
    struct StoreInfo: Encodable, Equatable {
        let storeImageUrl: String
        let openTime: Int
        let closeTime: Int
        let saleTimeStart: Int
        let closedDay: String?
    }
}
