//
//  CancelConfirmedOrderUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/05/03.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class CancelConfirmedOrderUseCaseImpl: CancelConfirmedOrderUseCase {
    // TODO: Remove Cancellables
    var cancellables = Set<AnyCancellable>()

    internal var service: OrderServiceProtocol
    
    init(service: OrderServiceProtocol = OrderService.shared) {
        self.service = service
    }
    
    func run(_ carts: [CartEntity], 
             for orderId: Int,
             at storeId: Int) async throws -> OrderEntity {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<OrderEntity, Error>) in
            
            // TODO: Add Mapper
            let dto = CancelConfirmedOrderDTO(
                orderList: carts.map {
                    CancelConfirmedOrderDTO.Order(
                        itemId: $0.itemId,
                        itemName: $0.name,
                        imageUrl: $0.imageUrl,
                        itemPrice: $0.price,
                        salePrice: $0.salePrice,
                        itemCount: $0.amount
                    )
                } 
            )
            
            self.service.cancelConfirmedOrder(dto, for: orderId, at: storeId)
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
