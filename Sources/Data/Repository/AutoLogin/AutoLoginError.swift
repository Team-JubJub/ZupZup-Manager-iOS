//
//  AutoLoginError.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 11/20/23.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

enum AutoLoginError: Error, Equatable {
    case noRefreshToken     // 요청에 필요한 헤더(리프레시 토큰)가 없음
    case tokenExpired       // 리프레시 토큰의 유효성 인증이 실패한 경우
    case unKnown            // 알 수 없는 에러 발생
}
