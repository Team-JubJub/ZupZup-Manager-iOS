//
//  GetAllOrdersUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/26/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

protocol GetAllOrdersUseCase {
    
    var service: OrderServiceProtocol { get set }
    
//    func getAllOrders(at storeId: Int) async throws -> [OrderEntity]
}
