//
//  ReservationItem.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ReservationItem: View {
    
    private let date: String = "2022/12/31 00:00"
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(
                    width: Device.Width * 358 / 390,
                    height: Device.Height * 104 / 844
                )
                .foregroundColor(Color.designSystem(.zupzupWarmGray3))
            Rectangle()
                .frame(
                    width: Device.Width * 358 / 390,
                    height: Device.Height * 45 / 844
                )
                .foregroundColor(Color.designSystem(.zupzupWarmGray4))
        }
        .cornerRadius(Device.cornerRadious)
    }
}
