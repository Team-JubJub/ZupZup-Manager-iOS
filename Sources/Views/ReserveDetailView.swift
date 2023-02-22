//
//  ReservationDetailView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ReserveDetailView: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    UnderTitleLabel()
                    VSpacer(height: Device.Height * 30 / 844)
                    SubTitleLabel(subtitle: "주문 정보")
                    VSpacer(height: Device.Height * 32 / 844)
                    ReserveInfoView(
                        customer: "김승창",
                        phoneNumber: "010-7777-7777",
                        arrivedTime: "19:00"
                    )
                    VSpacer(height: Device.Height * 48 / 844)
                    SubTitleLabel(subtitle: "주문 내역")
                    VSpacer(height: Device.Height * 21 / 844)
                    VStack(spacing: 8) {
                        ForEach(0..<10) { _ in
                            OrderItem(
                                itemName: "초코 크로와상",
                                price: "3000원",
                                count: 5
                            )
                        }
                    }
                }
                .frame(width: Device.Width * 358 / 390)
            }
            .navigationTitle("사이즈한도테스트테스트테스")
        }
        Button {
            print("tabbed")
        } label: {
            ZStack {
                Rectangle()
                    .frame(
                        width: Device.Width * 358 / 390,
                        height: Device.Height * 64 / 844
                    )
                    .foregroundColor(.designSystem(.zupzupMain))
                    .cornerRadius(Device.cornerRadious)
                Text("예약 확인하기")
                    .font(SystemFont(size: ._17, weight: .semibold))
                    .foregroundColor(.designSystem(.OffWhite))
            }
        }
    }
}
