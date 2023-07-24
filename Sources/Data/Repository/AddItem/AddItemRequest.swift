//
//  AddItemRequest.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/23.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import UIKit

struct AddItemRequest: Equatable {
    let item: Item
    let image: UIImage
    
    struct Item: Encodable, Equatable {
        let itemName: String
        let itemPrice: Int
        let salePrice: Int
        let itemCount: Int
    }
}
