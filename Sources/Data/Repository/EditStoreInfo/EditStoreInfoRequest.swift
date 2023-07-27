//
//  EditStoreInfoRequest.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import UIKit

struct EditStoreInfoRequest: Equatable {
    let data: StoreInfo
    let image: UIImage?
    
    struct StoreInfo: Encodable, Equatable {
        let storeImageUrl: String
        let openTime: String
        let closeTime: String
        let saleTimeStart: String
        let saleTimeEnd: String
        let closedDay: String?
    }
}
