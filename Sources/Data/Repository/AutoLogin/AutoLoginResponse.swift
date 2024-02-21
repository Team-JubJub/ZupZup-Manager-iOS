//
//  AutoLoginResponse.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 11/20/23.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct AutoLoginResponse: Codable, Equatable {
    let result: String
    let message: String
    let accessToken: String
    let loginId: String
}
