//
//  UpdateItemInfoRequest.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import UIKit

struct UpdateItemInfoRequest: Equatable {
    let itemid: Int
    let item: Item
    let image: UIImage?
    
    struct Item: Encodable, Equatable {
        let itemName: String
        let imageUrl: String
        let itemPrice: Int
        let salePrice: Int
        let itemCount: Int
    }
}
