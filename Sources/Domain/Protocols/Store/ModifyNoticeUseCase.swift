//
//  ModifyNoticeUseCase.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/27.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import UIKit

protocol ModifyNoticeUseCase: UseCase {
    var service: StoreServiceProtocol { get set }
    func run(at storeId: Int,
             notice: String,
             store: StoreEntity,
             image: UIImage) async throws -> Void
}
