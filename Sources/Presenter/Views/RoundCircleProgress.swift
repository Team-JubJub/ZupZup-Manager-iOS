//
//  RoundCircleProgress.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct RoundCircleProgress: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .padding()
            .frame(width: Device.Width, height: Device.Height)
            .background(Color.designSystem(.ScrimBlack40))
    }
}
