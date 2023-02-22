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
        ScrollView {
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
                
            }
            .frame(width: Device.Width * 358 / 390)
        }
        .navigationTitle("사이즈한도테스트테스트테스")
    }
}
