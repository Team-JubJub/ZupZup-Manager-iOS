//
//  SignInResponse.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct SignInResponse: Codable {
    let loginMessage: String
    let fireBaseStoreID: Int
}
