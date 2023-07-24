//
//  LoginResponse.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/19.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct LoginResponse: Codable, Equatable {
    let result: String
    let message: String
    let accessToken: String
    let refreshToken: String
    let storeId: Int
}
