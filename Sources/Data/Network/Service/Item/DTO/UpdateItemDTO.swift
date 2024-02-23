//
//  UpdateItemDTO.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/22/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import UIKit

struct UpdateItemDTO: Equatable, Multipartable {
    let itemid: Int
    let item: Item
    let image: UIImage
    
    struct Item: Codable, Equatable {
        let itemName: String
        let imageUrl: String
        let itemPrice: Int
        let salePrice: Int
        let itemCount: Int
    }
}
