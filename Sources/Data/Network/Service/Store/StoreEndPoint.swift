//
//  StoreEndPoint.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/23/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

enum StoreEndPoint: EndPoints {
    
    case getStore(_ storeId: Int)
    case modifyNotice(_ storeId: Int, notice: String)
    case toggleStoreState(_ storeId: Int, openState: Bool)
    case modifyStoreinfo(_ storeId: Int, uniqueString: String)
    
    var baseURL: String { return "zupzuptest.com" }
    
    var path: String {
        switch self {
        case let .getStore(storeId):
            return "/seller/\(storeId)"
            
        case let .modifyNotice(storeId, _):
            return "/seller/notice/\(storeId)"
            
        case let .toggleStoreState(storeId, _):
            return "/seller/open/\(storeId)"
        
        case let .modifyStoreinfo(storeId, _):
            return "/seller/modification/\(storeId)"
        }
    }
    
    var parameter: [URLQueryItem] {
        switch self {
        case .getStore:
            return []
            
        case let .modifyNotice(_, notice):
            return [URLQueryItem(name: "storeMatters", value: notice)]
            
        case let .toggleStoreState(_, openState):
            return [URLQueryItem(name: "isOpened", value: "\(openState)")]
                
        case .modifyStoreinfo:
            return []
        }
    }
    
    var headers: Headers {
        switch self {
        case .getStore:
            return [
                "accessToken": LoginManager.shared.getAccessToken(),
                "Content-Type": "application/json"
            ]
            
        case .modifyNotice:
            return [
                "accessToken": LoginManager.shared.getAccessToken(),
                "Content-Type": "application/json"
            ]
            
        case .toggleStoreState:
            return [
                "accessToken": LoginManager.shared.getAccessToken(),
                "Content-Type": "application/json"
            ]
            
        case let .modifyStoreinfo(_, uniqueString):
            return [
                "accessToken": LoginManager.shared.getAccessToken(),
                "Content-Type": "multipart/form-data; boundary=\(uniqueString)"
            ]
        }
    }
    
    var method: HTTPMethodd {
        switch self {
        case .getStore:
            return .get
            
        case .modifyNotice:
            return .post
            
        case .toggleStoreState:
            return .patch
            
        case .modifyStoreinfo:
            return .patch
        }
    }
}
