//
//  UpdateItemUseCase.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/27.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import UIKit

protocol UpdateItemUseCase: UseCase {
    var service: ItemServiceProtocol { get set }
    
    func run(item: ItemEntity,
             image: UIImage,
             for itemId: Int,
             at storeId: Int) async throws -> Void
}
