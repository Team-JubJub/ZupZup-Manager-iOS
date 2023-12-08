//
//  UrlManager.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/27.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import UIKit

final class UrlManager {
    
    static let shared = UrlManager()            // 싱글톤으로 관리
    
    private init() {}
    
#if DEBUG
    static let baseUrl = "https://zupzuptest.com:8080"
#else
    static let baseUrl = "https://zupzupofficial.com:8080"
#endif
    
#if DEBUG
    static let urlForDeleteStore = "https://zupzuptest.com:8095"
#else
    static let urlForDeleteStore = "https://zupzupofficial.com:8095"
#endif
    
#if DEBUG
    static let findMyAccountUrl = "https://zupzuptest.com:3000/find_id_main"
#else
    static let findMyAccountUrl = "https://zupzupofficial.com/find_id_main"
#endif
    
#if DEBUG
    static let findPasswordUrl = "https://zupzuptest.com/find_pw_main"
#else
    static let findPasswordUrl = "https://zupzupofficial.com/find_pw_main"
#endif
    
#if DEBUG
    static let makeAccountUrl = "https://zupzuptest.com:3000/signin_terms"
#else
    static let makeAccountUrl = "https://zupzupofficial.com/signin_terms"
#endif
    static let customerCenterUrl = "https://www.notion.so/ZupZup-Help-9de26b33bf164a9594db321e63f6e7ce?pvs=4"
}
