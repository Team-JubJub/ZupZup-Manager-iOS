//
//  UrlManager.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/27.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import UIKit

// MARK: 웹으로 전환을 담당하는 클래스
final class UrlManager {
    // 싱글톤으로 관리
    static let shared = UrlManager()
    
    private init() {}
}

extension UrlManager {
    
    // MARK: 고객센터 웹으로 전환
    func openCustomerCenter() {
        if let url = URL(string: "https://www.notion.so/ZupZup-Help-9de26b33bf164a9594db321e63f6e7ce?pvs=4") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openFindMyAccount() {
        // TODO: URL 수정
        if let url = URL(string: "https://zupzuptest.com:3000/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openMakeAccount() {
        // TODO: URL 수정
        if let url = URL(string: "https://zupzuptest.com:3000/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
