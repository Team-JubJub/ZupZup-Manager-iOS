//
//  UpdateItemInfoError.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 11/14/23.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

enum UpdateItemInfoError: Error, Equatable {
    case failToDecode    // 디코딩 오류
    case failToEncode    // 인코딩 오류
    case noImage         // 이미지 없음
    case noToken         // (400) 요청에 필요한 헤더(액세스 토큰)가 없음
    case tokenExpired    // (401) 액세스 토큰 만료, 로그아웃 혹은 회원탈퇴한 회원의 액세스 토큰
    case noItem          // (404) 해당 가게나 상품이 존재하지 않음
    case serverError     // (500) 내부 서버 오류
    case unKnown         // (그외) 알 수 없는 오류
}
