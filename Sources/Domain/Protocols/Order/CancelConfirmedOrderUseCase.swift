//
//  CancelConfirmedOrderUseCase.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/27.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

protocol CancelConfirmedOrderUseCase: UseCase {
    var service: OrderServiceProtocol { get }
    
    func run(_ carts: [CartEntity],
             for orderId: Int,
             at storeId: Int) async throws -> OrderEntity
}
