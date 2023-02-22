//
//  ReservationTimeLabel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct UnderTitleLabel: View {
    private let timeString: String = "2022년 11월 22일 09:41 (예약한 시간)"
    var body: some View {
        Text(timeString)
            .font(SystemFont(size: ._16, weight: .regular))
            .foregroundColor(.designSystem(.zupzupWarmGray5))
    }
}
