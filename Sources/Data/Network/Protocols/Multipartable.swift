//
//  Multipartable.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/22/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import UIKit

public protocol Multipartable {
    associatedtype Item: Codable
    
    var item: Item { get }
    var image: UIImage { get }
}
