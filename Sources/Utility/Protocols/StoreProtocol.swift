//
//  StoreProtocol.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/30.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

protocol StoreProtocol {
    associatedtype Action
    func reduce(action: Action)
}
