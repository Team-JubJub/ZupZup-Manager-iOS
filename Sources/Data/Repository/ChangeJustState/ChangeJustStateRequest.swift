//
//  ChangeStateRequest.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/24.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

struct ChangeJustStateRequest: Encodable, Equatable {
    let orderId: Int
    let state: State
    
    enum State: Encodable, Equatable {
        case cancel
        case complete
    }
}
