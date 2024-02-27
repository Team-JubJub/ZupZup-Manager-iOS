//
//  GetAllOrdersUseCaseImpl.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/26/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

class GetAllOrdersUseCaseImpl: GetAllOrdersUseCase {

    internal var service: OrderServiceProtocol
    
    init(service: OrderServiceProtocol = OrderService.shared) {
        self.service = service
    }
    
    func getAllOrders(at storeId: Int) -> AnyPublisher<[OrderEntity], NError> {
        return service.getAllOrders(at: storeId)
            .map { $0.toReservations() }
            .eraseToAnyPublisher()
    }
}
