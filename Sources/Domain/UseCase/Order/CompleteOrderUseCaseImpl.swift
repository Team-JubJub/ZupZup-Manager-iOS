//
//  CompleteOrderUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/05/05.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class CompleteOrderUseCaseImpl: CompleteOrderUseCase {
    
    // TODO: Remove Cancellables
    var cancellables = Set<AnyCancellable>()

    internal var service: OrderServiceProtocol
    
    init(service: OrderServiceProtocol = OrderService.shared) {
        self.service = service
    }
    
    func run(for orderId: Int, at storeId: Int) async throws -> OrderEntity {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<OrderEntity, Error>) in
            
            // TODO: Add Mapper
            self.service.completeOrder(for: orderId, at: storeId)
                .sink { completion in
                    // TODO: Error Handling
                    
                } receiveValue: { response in
                    // TODO: Add Mappers
                    let orderEntity = OrderEntity(
                        id: response.data.orderId,
                        customerName: response.data.userName,
                        phoneNumber: response.data.phoneNumber,
                        state: response.data.orderStatus.toReservationState,
                        storeId: response.data.storeId,
                        visitTime: response.data.visitTime,
                        cartList: response.data.orderList.map {
                            CartEntity(
                                itemId: $0.itemId,
                                amount: $0.itemCount,
                                name: $0.itemName,
                                price: $0.itemPrice,
                                imageUrl: "",
                                salePrice: $0.itemPrice
                            )
                        },
                        orderedItemdName: response.data.orderTitle,
                        orderedTime: response.data.orderTime
                    )
                    continuation.resume(returning: orderEntity)
                }
                .store(in: &cancellables)
        }
    }
}
