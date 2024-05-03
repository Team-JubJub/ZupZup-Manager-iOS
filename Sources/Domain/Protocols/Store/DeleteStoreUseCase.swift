//
//  DeleteStoreUseCase.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/29.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

protocol DeleteStoreUseCase: UseCase {
    var service: StoreServiceProtocol { get set }
    
    func run(at storeId: Int) async throws -> Void
}
