//
//  OrderServiceProtocol.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/21/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

protocol OrderServiceProtocol: Service {
    
    func confirmNewOrder(_ dto: ConfirmNewOrderDTO,
                         for orderId: Int,
                         at storeId: Int) -> AnyPublisher<ConfirmNewOrderResponse, NError>
    
    func cancelNewOrder(for orderId: Int,
                        at storeId: Int) -> AnyPublisher<CancelNewOrderResponse, NError>
    
    func completeOrder(for orderId: Int,
                       at storeId: Int) -> AnyPublisher<CompleteOrderResponse, NError>
    
    func cancelConfirmedOrder(_ dto: ConfirmNewOrderDTO,
                              for orderId: Int,
                              at storeId: Int) -> AnyPublisher<CancelConfirmedOrderResponse, NError>
    
    func getAllOrders(at storeId: Int) -> AnyPublisher<GetAllOrdersResponse, NError>
}
