//
//  LoginManager.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

final class LoginManager {
    
    static let shared = LoginManager()
    
    static let accessToken = "accessToken"
    static let refreshToken = "refreshToken"
    
    static let storeID = "storeID"
    
    private init() { }
}

extension LoginManager {
    static func setAccessToken(newToken: String) {
        UserDefaults.standard.set(newToken, forKey: LoginManager.accessToken)
    }
    
    static func setRefresh(newToken: String) {
        UserDefaults.standard.set(newToken, forKey: LoginManager.refreshToken)
    }
    
    static func setStoreId(id: Int) {
        UserDefaults.standard.set(id, forKey: LoginManager.storeID)
    }
    
    static func getAccessToken() -> String {
        guard let token = UserDefaults.standard.string(forKey: LoginManager.accessToken) else { return "" }
        return token
    }
    
    static func getRefreshToken() -> String {
        guard let token = UserDefaults.standard.string(forKey: LoginManager.refreshToken) else { return "" }
        return token
    }
    
    static func getStoreId() -> Int? {
        return UserDefaults.standard.integer(forKey: LoginManager.storeID)
    }
}
