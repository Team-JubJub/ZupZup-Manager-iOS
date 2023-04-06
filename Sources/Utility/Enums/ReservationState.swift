//
//  ReservationState.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

enum ReservationState {
    case new
    case confirm
    case complete
    case cancel
    
    var rawString: String {
        switch self {
        case .new:
            return "NEW"
        case .cancel:
            return "CANCEL"
        case .confirm:
            return "CONFIRM"
        case .complete:
            return "COMPLETE"
        }
    }
}
