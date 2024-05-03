//
//  ModifyStoreinfoUseCase.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/27.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import UIKit

protocol ModifyStoreinfoUseCase: UseCase {
    var service: StoreServiceProtocol { get set }
    func run(store: StoreEntity,
             image: UIImage,
             at storeId: Int) async throws -> Void
}
