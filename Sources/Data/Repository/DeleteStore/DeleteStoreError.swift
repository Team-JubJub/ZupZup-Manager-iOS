//
//  DeleteStoreError.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

enum DeleteStoreError: Error, Equatable {
    case failToDecode    // 디코딩 오류
    case failToEncode    // 인코딩 오류
    case badRequest         // (400) 이미 탈퇴한 회원
    case serverError     // (500) 내부 서버 오류
    case unKnown         // (그외) 알 수 없는 오류
}
