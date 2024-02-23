//
//  ItemServiceProtocol.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/22/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

protocol ItemServiceProtocol {
    
    func addItem(_ dto: AddItemDTO, at storeId: Int) -> AnyPublisher<Void, NError>
    
    func deleteItem(for itemId: Int, at storeId: Int) -> AnyPublisher<Void, NError>
    
    func updateItem(_ dto: UpdateItemDTO, for itemId: Int, at storeId: Int) -> AnyPublisher<Void, NError>
    
    func modifyItemCount(_ dto: ModifyItemCountDTO, for itemId: Int) -> AnyPublisher<Void, NError>
    
    func getAllItems(at storeId: Int) -> AnyPublisher<GetAllItemsResponse, NError>
}
