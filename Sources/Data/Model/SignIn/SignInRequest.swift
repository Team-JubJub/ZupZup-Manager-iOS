//
//  SignInRequest.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct SignInRequest: Codable {
    let loginId: String
    let loginPwd: String
}
