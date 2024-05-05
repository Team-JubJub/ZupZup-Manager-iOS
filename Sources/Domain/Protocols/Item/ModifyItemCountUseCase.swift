//
//  ModifyItemCountUseCase.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/27.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

protocol ModifyItemCountUseCase: UseCase {
    var service: ItemServiceProtocol { get set }
    func run(items: [ItemEntity], at storeId: Int) async throws -> Void
}
