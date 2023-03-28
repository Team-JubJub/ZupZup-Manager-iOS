//
//  ReservationItem.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ReservationItem: View {
    
    @State var date: String
    @State var menu: String
    @State var time: String
    @State var customer: String
    @State var state: ReservationState
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                Rectangle()
                    .foregroundColor(Color.designSystem(.zupzupWarmGray3))
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(date)
                            .foregroundColor(.designSystem(.zupzupCoolGray1))
                            .font(SystemFont(size: ._15, weight: .regular))
                        Text(menu)
                            .lineLimit(1)
                            .foregroundColor(.designSystem(.Secondary))
                            .font(SystemFont(size: ._22, weight: .bold))
                    }
                    Spacer()
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
                .frame(width: Device.Width * 326 / 390)
            }
            .frame(
                width: Device.Width * 358 / 390,
                height: Device.Height * 104 / 844
            )
            ZStack {
                Rectangle()
                    .foregroundColor(.designSystem(.zupzupWarmGray4))
                HStack(spacing: 0) {
                    Image(assetName: .clock)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: Device.HPadding,
                                bottom: 0,
                                trailing: Device.Width * 6.5 / 390
                            )
                        )
                    Text(time)
                        .foregroundColor(.designSystem(.Secondary))
                        .font(SystemFont(size: ._17, weight: .regular))
                    Spacer()
                    Text(customer)
                        .lineLimit(1)
                        .foregroundColor(.designSystem(.Secondary))
                        .font(SystemFont(size: ._17, weight: .regular))
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: Device.Width * 24 / 390
                            )
                        )
                }
            }
            .frame(
                width: Device.Width * 358 / 390,
                height: Device.Height * 45 / 844
            )
        }
        .cornerRadius(Device.cornerRadious)
    }
}

extension ReservationItem {
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
