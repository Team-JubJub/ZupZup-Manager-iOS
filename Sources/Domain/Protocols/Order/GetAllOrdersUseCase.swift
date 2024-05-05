//
//  GetAllOrdersUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/26/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

protocol GetAllOrdersUseCase: UseCase {
    
    var service: OrderServiceProtocol { get set }
    
    func run(at storeId: Int) async throws -> [OrderEntity]
}
