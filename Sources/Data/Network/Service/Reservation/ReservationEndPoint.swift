////
////  ReservationEndPoint.swift
////  ZupZupManager
////
////  Created by YeongJin Jeong on 2/21/24.
////  Copyright © 2024 ZupZup. All rights reserved.
////
//
//import Foundation
//
//enum OrderEndPoint: EndPoints {
//    
//    case confirmNewOrder
//    case cancelNewOrder
//    case completeOrder
//    case cancelConfirmOrder
//    case fetchAllOrders
//    case getDetail
//    
//    var baseURL: String { return "zupzuptest.com" }
//    
//    var path: String {
//        switch self {
//        case .confirmNewOrder:
//            return "/seller/{storeId}/order/new-order/{orderId}/confirm"
//        case .cancelNewOrder:
//            return "/seller/{storeId}/order/new-order/{orderId}/cancel"
//        case .completeOrder:
//            return "/seller/{storeId}/order/confirmed-order/{orderId}/complete"
//        case .cancelConfirmOrder:
//            return "/seller/{storeId}/order/confirmed-order/{orderId}/cancel"
//        case .fetchAllOrders:
//            return "/seller/{storeId}/order"
//        case .getDetail:
//            return "/seller/{storeId}/order/{orderId}"
//        }
//    }
//    
//    var parameter: [URLQueryItem] {
//        return []
//    }
//    
//    var headers: Headers {
//        
//    }
//    
//    var method: HTTPMethodd {
//        switch self {
//        case .confirmNewOrder:
//            return .patch
//        case .cancelNewOrder:
//            return .patch
//        case .completeOrder:
//            return .patch
//        case .cancelConfirmOrder:
//            return .patch
//        case .fetchAllOrders:
//            return .get
//        case .getDetail:
//            return .get
//        }
//    }
//}
//
