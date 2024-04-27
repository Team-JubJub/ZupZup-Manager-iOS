//
//  GetAllItemsUseCase.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/27.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

protocol GetAllItemsUseCase: UseCase {
    var service: ItemServiceProtocol { get set }
    func run() async throws -> [ItemEntity]
}
