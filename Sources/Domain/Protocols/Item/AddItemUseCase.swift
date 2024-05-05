//
//  AddItemUseCase.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/27.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import UIKit

protocol AddItemUseCase: UseCase {
    
    var service: ItemServiceProtocol { get set }
    
    func run(item: ItemEntity,
             image: UIImage,
             at storeId: Int) async throws -> Void
}
