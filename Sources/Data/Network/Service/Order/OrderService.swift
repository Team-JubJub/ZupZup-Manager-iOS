//
//  OrderService.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/21/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class OrderService: OrderServiceProtocol {
    
    var subscriptions = Set<AnyCancellable>()
    
    private let networkRequest: Requestable
    
    static let shared = OrderService()
    
    private init(networkRequest: Requestable = NetworkRequestable()) {
        self.networkRequest = networkRequest
    }
    
    func confirmNewOrder(_ dto: ConfirmNewOrderDTO, 
                         for orderId: Int,
                         at storeId: Int) -> AnyPublisher<ConfirmNewOrderResponse, NError> {
        let endPoint = OrderEndPoint.confirmNewOrder(storeId, orderId)
        let request = RequestModel(endPoints: endPoint, requestBody: dto)
        return self.networkRequest.request(request)
    }
    
    func cancelNewOrder(for orderId: Int, at storeId: Int) -> AnyPublisher<CancelNewOrderResponse, NError> {
        let endPoint = OrderEndPoint.cancelNewOrder(storeId, orderId)
        let request = RequestModel(endPoints: endPoint)
        return self.networkRequest.request(request)
    }
    
    func completeOrder(for orderId: Int, at storeId: Int) -> AnyPublisher<CompleteOrderResponse, NError> {
        let endPoint = OrderEndPoint.completeOrder(storeId, orderId)
        let request = RequestModel(endPoints: endPoint)
        return self.networkRequest.request(request)
    }
    
    func cancelConfirmedOrder(_ dto: ConfirmNewOrderDTO,
                              for orderId: Int,
                              at storeId: Int) -> AnyPublisher<CancelConfirmedOrderResponse, NError> {
        let endPoint = OrderEndPoint.cancelConfirmedOrder(storeId, orderId)
        let request = RequestModel(endPoints: endPoint, requestBody: dto)
        return self.networkRequest.request(request)
    }
    
    func getAllOrders(at storeId: Int) -> AnyPublisher<GetAllOrdersResponse, NError> {
        let endPoint = OrderEndPoint.getAllOrders(storeId)
        let request = RequestModel(endPoints: endPoint)
        return self.networkRequest.request(request)
    }
}
