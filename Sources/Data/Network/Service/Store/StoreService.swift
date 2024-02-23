//
//  StoreService.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/23/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class StoreService: StoreServiceProtocol {
    
    var subscription = Set<AnyCancellable>()
    
    private let networkRequest: Requestable
    
    static let shared = StoreService()
    
    private init(networkRequest: Requestable = NetworkRequestable()) {
        self.networkRequest = networkRequest
    }
    
    func getStore(at storeId: Int) -> AnyPublisher<GetStoreResponse, NError> {
        let endPoint = StoreEndPoint.getStore(storeId)
        let request = RequestModel(endPoints: endPoint)
        return self.networkRequest.request(request)
    }
    
    func modifyNotice(at storeId: Int, notice: String) -> AnyPublisher<Void, NError> {
        let endPoint = StoreEndPoint.modifyNotice(storeId, notice: notice)
        let request = RequestModel(endPoints: endPoint)
        return self.networkRequest.justRequest(request)
    }
    
    func toggleStoreState(at storeId: Int, openState: Bool) -> AnyPublisher<Void, NError> {
        let endPoint = StoreEndPoint.toggleStoreState(storeId, openState: openState)
        let request = RequestModel(endPoints: endPoint)
        return self.networkRequest.justRequest(request)
    }
    
    func modifyStoreinfo(_ dto: ModifyStoreInfoDTO, at storeId: Int) -> AnyPublisher<Void, NError> {
        let uniqueString = UUID().uuidString
        let endPoint = StoreEndPoint.modifyStoreinfo(storeId, uniqueString: uniqueString)
        let request = RequestModel(
            endPoints: endPoint,
            multipartBody: dto,
            multipartType: .data,
            uniqueString: uniqueString
        )
        return self.networkRequest.justRequest(request)
    }
}
