//
//  ModifyItemCountDTO.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/22/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

public struct ModifyItemCountDTO: Codable, Equatable {
    
    let quantity: [Quantity]
    
    public struct Quantity: Codable, Equatable {
        let itemId: Int
        let itemName: String
        let imageURL: String
        let itemPrice: Int
        let salePrice: Int
        let itemCount: Int
    }
}
