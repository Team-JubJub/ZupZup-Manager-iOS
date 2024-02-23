//
//  ItemEndPoint.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/22/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

enum ItemEndPoint: EndPoints {
    
    case addItem(_ storeId: Int, uniqueString: String)
    case deleteItem(_ itemId: Int, _ storeId: Int)
    case updateItem(_ itemId: Int, _ storeId: Int, uniqueString: String)
    case modifyItemCount(_ itemId: Int, uniqueString: String)
    case getAllItems(_ storeId: Int)
    
    var baseURL: String { return "zupzuptest.com"}
    
    var path: String {
        switch self {
        case let .addItem(itemId, _):
            return "/seller/\(itemId)"
            
        case let .deleteItem(itemId, storeId):
            return "/seller/\(storeId)/\(itemId)"
            
        case let .updateItem(itemId, storeId, _):
            return "/seller/\(storeId)/\(itemId)"
            
        case let .modifyItemCount(itemId, _):
            return "/seller/\(itemId)/quantity"
            
        case let .getAllItems(storeId):
            return "/seller/\(storeId)/management"
        }
    }
    
    var parameter: [URLQueryItem] {
        return []
    }
    
    var headers: Headers {
        switch self {
        case let .addItem(_, uniqueString):
            return [
                "accessToken": LoginManager.shared.getAccessToken(),
                "Content-Type": "multipart/form-data; boundary=\(uniqueString)"
            ]
            
        case .deleteItem:
            return [
                "accessToken": LoginManager.shared.getAccessToken(),
                "Content-Type": "application/json"
            ]
            
        case let .updateItem(_, _, uniqueString):
            return [
                "accessToken": LoginManager.shared.getAccessToken(),
                "Content-Type": "multipart/form-data; boundary=\(uniqueString)"
            ]
            
        case let .modifyItemCount(_, uniqueString):
            return [
                "accessToken": LoginManager.shared.getAccessToken(),
                "Content-Type": "multipart/form-data; boundary=\(uniqueString)"
            ]
            
        case .getAllItems:
            return [
                "accessToken": LoginManager.shared.getAccessToken(),
                "Content-Type": "application/json"
            ]
        }
        
    }
    
    var method: HTTPMethodd {
        switch self {
        case .addItem:
            return .post
            
        case .deleteItem:
            return .delete
            
        case .updateItem:
            return .patch
            
        case .modifyItemCount:
            return .patch
            
        case .getAllItems:
            return .get
        }
    }
}
