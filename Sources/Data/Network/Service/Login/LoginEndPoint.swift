//
//  LoginEndPoint.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/20/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

enum LoginEndPoint: EndPoints {
    
    case autoLogin
    case login
    
    var baseURL: String { return UrlManager.baseUrl }
    
    var path: String {
        switch self {
        case .autoLogin:
            return "/mobile/sign-in/refresh"
        case .login:
            return "/mobile/sign-in"
        }
    }
    
    var parameter: [URLQueryItem]? {
        switch self {
        case .autoLogin:
            return nil
        case .login:
            return nil
        }
    }
    
    var headers: Headers {
        switch self {
        case .autoLogin:
            return ["refreshToken": LoginManager.shared.getRefreshToken()]
        case .login:
            return ["accessToken": LoginManager.shared.getAccessToken()]
        }
    }
    
    var method: HTTPMethodd {
        switch self {
        case .autoLogin:
            return .post
        case .login:
            return .post
        }
    }
}
