//
//  ReservationState.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

enum ReservationCondition: Equatable, Encodable {
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
    
    var stateColor: Color? {
        switch self {
        case .new:
            return Color.designSystem(.orange400)
        case .confirm:
            return Color.designSystem(.Tangerine300)
        case .complete:
            return Color.designSystem(.green300)
        case .cancel:
            return Color.designSystem(.ivoryGray400)
        }
    }
    
    var itemTextColor: Color? {
        switch self {
        case .new, .confirm:
            return .designSystem(.pureBlack)
        case .complete:
            return .designSystem(.coolGray600)
        case .cancel:
            return .designSystem(.ivoryGray300)
        }
    }
    
    var dateTextColor: Color? {
        switch self {
        case .cancel:
            return .designSystem(.ivoryGray300)
        default:
            return .designSystem(.coolGray600)
        }
    }
    
    var bottomTextColor: Color? {
        switch self {
        case .cancel:
            return .designSystem(.ivoryGray150)
        default:
            return .designSystem(.pureBlack)
        }
    }
}

extension ReservationCondition {
    func toChangeStateCondition() -> ChangeStateRequest.State {
        switch self {
        case .confirm: return .confirm
        case .cancel: return .cancel
        default: return .cancel
        }
    }
    
    func toJustChangeStateCondition() -> ChangeJustStateRequest.State {
        switch self {
        case .cancel: return .cancel
        case .complete: return .complete
        default: return .cancel
        }
    }
}
