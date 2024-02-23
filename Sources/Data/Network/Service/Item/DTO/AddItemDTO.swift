//
//  AddItemDTO.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/22/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import UIKit

struct AddItemDTO: Equatable, Multipartable {
    
    var item: Item
    var image: UIImage
    
    struct Item: Codable, Equatable {
        let itemName: String
        let itemPrice: Int
        let salePrice: Int
        let itemCount: Int
    }
}
