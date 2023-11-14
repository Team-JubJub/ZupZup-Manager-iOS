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
    static let deviceToken = "deviceToken"
    static let storeID = "storeID"
    
    private init() { }
}

extension LoginManager {
    func setAccessToken(newToken: String) {
        UserDefaults.standard.set(newToken, forKey: LoginManager.accessToken)
    }
    
    func setRefresh(newToken: String) {
        UserDefaults.standard.set(newToken, forKey: LoginManager.refreshToken)
    }
    
    func setStoreId(id: Int) {
        UserDefaults.standard.set(id, forKey: LoginManager.storeID)
    }
    
    func setDeviceToken(newToken: String?) {
        UserDefaults.standard.set(newToken, forKey: LoginManager.deviceToken)
    }
    
    func getAccessToken() -> String {
        guard let token = UserDefaults.standard.string(forKey: LoginManager.accessToken) else { return "" }
        return token
    }
    
    func getRefreshToken() -> String {
        guard let token = UserDefaults.standard.string(forKey: LoginManager.refreshToken) else { return "" }
        return token
    }
    
    func getDeviceToken() -> String {
        guard let token = UserDefaults.standard.string(forKey: LoginManager.deviceToken) else { return "" }
        return token
    }
    
    func getStoreId() -> Int {
        return UserDefaults.standard.integer(forKey: LoginManager.storeID)
    }
    
    func isLoginValid() -> Bool {
        return getStoreId() != 0 && getAccessToken().isEmpty && getRefreshToken().isEmpty
    }
    
    func removeStoreId() {
        UserDefaults.standard.removeObject(forKey: LoginManager.storeID)
    }
}
