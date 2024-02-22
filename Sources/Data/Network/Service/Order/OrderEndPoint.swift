//
//  OrderEndPoint.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/21/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

enum OrderEndPoint: EndPoints {
    
    case confirmNewOrder(_ storeId: Int, _ orderId: Int)
    case cancelNewOrder(_ storeId: Int, _ orderId: Int)
    case completeOrder(_ storeId: Int, _ orderId: Int)
    case cancelConfirmedOrder(_ storeId: Int, _ orderId: Int)
    case getAllOrders(_ storeId: Int)
    case getStoreDetails(_ storeId: Int, _ orderId: Int)
    
    var baseURL: String { return "zupzuptest.com" }
    
    var path: String {
        switch self {
        case let .confirmNewOrder(storeId, orderId):
            return "/seller/\(storeId)/order/new-order/\(orderId)/confirm"
            
        case let .cancelNewOrder(storeId, orderId):
            return "/seller/\(storeId)/order/new-order/\(orderId)/cancel"
            
        case let .completeOrder(storeId, orderId):
            return "/seller/\(storeId)/order/confirmed-order/\(orderId)/complete"
            
        case let .cancelConfirmedOrder(storeId, orderId):
            return "/seller/\(storeId)/order/confirmed-order/\(orderId)/cancel"
            
        case let .getAllOrders(storeId):
            return "/seller/\(storeId)/order"
            
        case let .getStoreDetails(storeId, orderId):
            return "/seller/\(storeId)/order/\(orderId)"
        }
    }
    
    var parameter: [URLQueryItem] {
        return []
    }
    
    var headers: Headers {
        return [
            "accessToken": LoginManager.shared.getAccessToken(),
            "Content-Type": "application/json"
        ]
    }
    
    var method: HTTPMethodd {
        switch self {
        case .confirmNewOrder:
            return .patch
            
        case .cancelNewOrder:
            return .patch
            
        case .completeOrder:
            return .patch
            
        case .cancelConfirmedOrder:
            return .patch
            
        case .getAllOrders:
            return .get
            
        case .getStoreDetails:
            return .get
        }
    }
}
