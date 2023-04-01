//
//  ReserveInfoView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ReserveInfoView: View {
    
    let customer: String
    let phoneNumber: String
    let arrivedTime: String
    
    var body: some View {
        ZStack {
            VStack(spacing: 1) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.designSystem(.zupzupWarmGray3))
                        .frame(height: 97)
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            RectangleWithIcon(assetName: .ic_user)
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                        VStack(alignment: .leading, spacing: 0) {
                            Text("주문자")
                                .font(SystemFont(size: ._12, weight: .semibold))
                                .foregroundColor(.designSystem(.zupzupMain))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            Text(customer)
                                .font(SystemFont(size: ._17, weight: .regular))
                                .foregroundColor(.designSystem(.Secondary))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            Text(phoneNumber)
                                .font(SystemFont(size: ._13, weight: .regular))
                                .foregroundColor(.designSystem(.zupzupWarmGray6))
                            Spacer()
                        }
                        .frame(height: 65)
                        Spacer()
                    }
                    .frame(
                        width: Device.Width * 326 / 390,
                        height: 65
                    )
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(.designSystem(.zupzupWarmGray3))
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            RectangleWithIcon(assetName: .ic_clock)
                            Spacer()
                        }
                        .padding(
                            EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
                        )
                        VStack(alignment: .leading, spacing: 0) {
                            Text("방문 예정 시간")
                                .font(SystemFont(size: ._12, weight: .semibold))
                                .foregroundColor(.designSystem(.zupzupMain))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            Text(arrivedTime)
                                .font(SystemFont(size: ._17, weight: .regular))
                                .foregroundColor(.designSystem(.Secondary))
                            Spacer()
                        }
                        .frame(height: 42)
                        Spacer()
                    }
                    .frame(
                        width: Device.Width * 326 / 390,
                        height: 42
                    )
                }
            }
            .frame(
                width: Device.Width * 358 / 390,
                height: 172
            )
            .cornerRadius(Device.cornerRadious)
        }
    }
}
