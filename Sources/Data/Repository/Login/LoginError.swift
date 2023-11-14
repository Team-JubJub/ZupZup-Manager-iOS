//
//  LoginError.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 11/14/23.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

enum LoginError: Error, Equatable {
    case failToDecode    // 디코딩 오류
    case failToEncode    // 인코딩 오류
    case badRequest      // (400) Request body 파라미터가 잘못된 경우, Request body의 값이 유효셩에 어긋나는 경우
    case noStore         // (401) 가게가 없는 경우
    case wrongPassword   // (403) 아이디를 통한 로그인 시 비밀번호가 틀린 경우
    case wrongId         // (404) 제공된 login ID를 가진 사장님 조회가 불가능한 경우(login ID가 잘못된 경우)
    case serverError     // (500) 내부 서버 오류
    case unKnown         // (그외) 알 수 없는 오류
}
