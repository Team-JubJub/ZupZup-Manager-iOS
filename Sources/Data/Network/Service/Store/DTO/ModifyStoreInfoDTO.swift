//
//  ModifyStoreInfoDTO.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/23/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import UIKit

struct ModifyStoreInfoDTO: Equatable, Multipartable {
    struct StoreInfo: Codable, Equatable {
        let storeImageUrl: String
        let openTime: String
        let closeTime: String
        let saleTimeStart: String
        let saleTimeEnd: String
        let closedDay: String?
    }
    
    let item: StoreInfo
    let image: UIImage
}
