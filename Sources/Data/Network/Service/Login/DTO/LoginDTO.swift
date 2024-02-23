//
//  LoginDTO.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/20/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

struct LoginDTO: Encodable {
    let loginId: String
    let loginPwd: String
    let deviceToken: String
}
