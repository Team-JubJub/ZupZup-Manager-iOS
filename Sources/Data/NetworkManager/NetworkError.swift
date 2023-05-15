//
//  NetworkError.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case failToDecode
    case failToEncode
    case invalidResponse
    case requestFailed(Error)
}
