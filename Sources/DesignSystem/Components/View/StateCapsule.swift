//
//  StateCapsule.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/04.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct StateCapsule: View {
    
    @Binding var state: ReservationState
    
    var body: some View {
        ZStack {
            Capsule(style: .circular)
                .frame(width: 75, height: 36)
                .foregroundColor(getCapsuleColor(state: state))
            SuitLabel(text: getCapsuleText(state: state), typo: .subhead, color: getCapsuleTextColor(state: state))
        }
    }
}

extension StateCapsule {
    func getCapsuleColor(state: ReservationState) -> Color? {
        switch state {
        case .new:
            return Color.designSystem(.orange400)
        case .confirm:
            return Color.designSystem(.Tangerine300)
        case .complete:
            return Color.designSystem(.green300)
        case .cancel:
            return Color.designSystem(.ivoryGray300)
        }
    }
    
    func getCapsuleText(state: ReservationState) -> String {
        switch state {
        case .new:
            return "신규"
        case .confirm:
            return "확정"
        case .complete:
            return "완료"
        case .cancel:
            return "취소"
        }
    }
    
    func getCapsuleTextColor(state: ReservationState) -> Color? {
        switch state {
        case .new:
            return .designSystem(.Secondary)
        case .confirm:
            return .designSystem(.pureBlack)
        case .complete:
            return .designSystem(.pureBlack)
        case .cancel:
            return .designSystem(.pureBlack)
        }
    }
}
