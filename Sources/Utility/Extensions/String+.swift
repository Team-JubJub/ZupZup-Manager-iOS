//
//  String+.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

extension String {
    
    /// DB에 있는 String형태의 state를 Enum으로 관리하기 위함
    var toReservationState: ReservationState {
        switch self {
        case "NEW":
            return ReservationState.new
        case "CONFIRM":
            return ReservationState.confirm
        case "COMPLETE":
            return ReservationState.complete
        case "CANCEL":
            return ReservationState.cancel
        default:
            return ReservationState.new
        }
    }
}
