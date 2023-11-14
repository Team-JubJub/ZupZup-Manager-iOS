//
//  NetworkError.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

enum NetworkError: Error, Equatable {
    case failToDecode           // 디코딩 오류
    case failToEncode           // 인코딩 오류
    case invalidResponse
    case requestFailed          // 400 : request body 오류
    case tokenExpired           // 401 : 엑세스 토큰 만료
    
}
