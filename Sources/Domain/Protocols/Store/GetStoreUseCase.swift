//
//  GetStoreUseCase.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/27.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

protocol GetStoreUseCase: UseCase {
    var service: StoreServiceProtocol { get set }
    func run(at storeId: Int) async throws -> StoreEntity
}
