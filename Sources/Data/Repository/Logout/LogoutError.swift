//
//  LogoutError.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

enum LogoutError: Error, Equatable {
    case failToDecode    // 디코딩 오류
    case failToEncode    // 인코딩 오류
    case noRefreshToken      // (400) Request body 파라미터가 잘못된 경우, Request body의 값이 유효셩에 어긋나는 경우
    case accessDenyed         // (401) 가게가 없는 경우
    case noAccessToken   // (403) 아이디를 통한 로그인 시 비밀번호가 틀린 경우
    case serverError     // (500) 내부 서버 오류
    case unKnown         // (그외) 알 수 없는 오류
}
