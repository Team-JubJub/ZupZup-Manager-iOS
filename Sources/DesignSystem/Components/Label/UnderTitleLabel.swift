//
//  ReservationTimeLabel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct UnderTitleLabel: View {
    let timeString: String
    var body: some View {
        Text(timeString)
            .font(SystemFont(size: ._16, weight: .regular))
            .foregroundColor(.designSystem(.warmGray5))
    }
}
