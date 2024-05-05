//
//  GetAllOrdersUseCaseImpl.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/26/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class GetAllOrdersUseCaseImpl: GetAllOrdersUseCase {
    
    var cancellables = Set<AnyCancellable>()

    internal var service: OrderServiceProtocol
    
    init(service: OrderServiceProtocol = OrderService.shared) {
        self.service = service
    }
    
    func run(at storeId: Int) async throws -> [OrderEntity] {
        
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[OrderEntity], Error>) in
            
            self.service.getAllOrders(at: storeId)
                .sink { completion in
                    // TODO: Error Handling
                    
                } receiveValue: { response in
                    continuation.resume(returning: response.toReservations())
                }
                .store(in: &cancellables)
        }
    }
}
