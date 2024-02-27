//
//  ConfirmNewOrderUseCase.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/27/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

protocol ConfirmNewOrderUseCase {
    var orderService: OrderServiceProtocol { get }
    
//    func confirmNewOrder() -> AnyPublisher<NError>
    
}
