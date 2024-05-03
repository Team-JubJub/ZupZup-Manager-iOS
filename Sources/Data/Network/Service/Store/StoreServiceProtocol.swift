//
//  StoreServiceProtocol.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/23/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

protocol StoreServiceProtocol: Service {
    
    func getStore(at storeId: Int) -> AnyPublisher<GetStoreResponse, NError>
    
    func modifyNotice(at storeId: Int, notice: String) -> AnyPublisher<Void, NError>
    
    func toggleStoreState(at storeId: Int, openState: Bool) -> AnyPublisher<Void, NError>
    
    func modifyStoreinfo(_ dto: ModifyStoreInfoDTO, at storeId: Int) -> AnyPublisher<Void, NError>
    
    func deleteStore(at storeId: Int) -> AnyPublisher<Void, NError>
}
