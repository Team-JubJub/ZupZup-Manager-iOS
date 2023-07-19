//
//  LoginRequest.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/19.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct LoginRequest: Encodable {
    let loginId: String
    let loginPwd: String
}
