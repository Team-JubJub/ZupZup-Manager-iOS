//
//  ItemService.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/22/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class ItemService: ItemServiceProtocol {
    
    var subscriptions = Set<AnyCancellable>()
    
    private let networkRequest: Requestable
    
    static let shared = ItemService()
    
    private init(networkRequest: Requestable = NetworkRequestable()) {
        self.networkRequest = networkRequest
    }
    
    // ok
    func addItem(_ dto: AddItemDTO, at storeId: Int) -> AnyPublisher<Void, NError> {
        let uniqueString = UUID().uuidString
        let endPoint = ItemEndPoint.addItem(storeId, uniqueString: uniqueString)
        let request = RequestModel(
            endPoints: endPoint,
            multipartBody: dto,
            multipartType: .item,
            uniqueString: uniqueString
        )
        return self.networkRequest.justRequest(request)
    }
    
    // ok
    func deleteItem(for itemId: Int, at storeId: Int) -> AnyPublisher<Void, NError> {
        let endPoint = ItemEndPoint.deleteItem(itemId, storeId)
        let request = RequestModel(endPoints: endPoint)
        return self.networkRequest.justRequest(request)
    }
    
    // ok
    func updateItem(_ dto: UpdateItemDTO, for itemId: Int, at storeId: Int) -> AnyPublisher<Void, NError> {
        let uniqueString = UUID().uuidString
        let endPoint = ItemEndPoint.updateItem(itemId, storeId, uniqueString: uniqueString)
        let request = RequestModel(
            endPoints: endPoint,
            multipartBody: dto,
            multipartType: .item,
            uniqueString: uniqueString
        )
        return self.networkRequest.justRequest(request)
    }
    
    func modifyItemCount(_ dto: ModifyItemCountDTO, at itemId: Int) -> AnyPublisher<Void, NError> {
        let uniqueString = UUID().uuidString
        let endPoint = ItemEndPoint.modifyItemCount(itemId, uniqueString: uniqueString)
        let request = RequestModel(endPoints: endPoint, contentBody: dto, uniqueString: uniqueString)
        return self.networkRequest.justRequest(request)
    }
    
    // ok
    func getAllItems(at storeId: Int) -> AnyPublisher<GetAllItemsResponse, NError> {
        let endPoint = ItemEndPoint.getAllItems(storeId)
        let request = RequestModel(endPoints: endPoint)
        return self.networkRequest.request(request)
    }
}
