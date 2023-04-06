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
                .frame(
                    width: 75,
                    height: 36
                )
                .foregroundColor(
                    getCapsuleColor(state: state)
                )
            Text(
                getCapsuleText(state: state)
            )
            .font(SystemFont(size: ._15, weight: .regular))
            .foregroundColor(
                getCapsuleTextColor(state: state)
            )
        }
    }
}

extension StateCapsule {
    func getCapsuleColor(state: ReservationState) -> Color? {
        switch state {
        case .new:
            return Color.designSystem(.BG_2)
        case .confirm:
            return Color.designSystem(.confirmColor)
        case .complete:
            return Color.designSystem(.completeColor)
        case .cancel:
            return Color.designSystem(.zupzupWarmGray5)
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
            return .designSystem(.OffWhite)
        case .complete:
            return .designSystem(.zupzupCoolGray1)
        case .cancel:
            return .designSystem(.zupzupWarmGray3)
        }
    }
}
