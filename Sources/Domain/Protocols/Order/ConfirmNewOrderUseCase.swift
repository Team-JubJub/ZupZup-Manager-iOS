//
//  ConfirmNewOrderUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/27/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

protocol ConfirmNewOrderUseCase: UseCase {
    
    var service: OrderServiceProtocol { get }
    
    func run(_ carts: [CartEntity],
             for orderId: Int,
             at storeId: Int) async throws -> OrderEntity
}
