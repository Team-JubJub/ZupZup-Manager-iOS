//
//  BottomButtonLabel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct BottomButtonLabel: View {
    
    let buttonTitle: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(
                    width: Device.Width * 358 / 390,
                    height: Device.Height * 64 / 844
                )
                .foregroundColor(.designSystem(.zupzupMain))
                .cornerRadius(Device.cornerRadious)
            Text(buttonTitle)
                .font(SystemFont(size: ._17, weight: .semibold))
                .foregroundColor(.designSystem(.OffWhite))
        }
    }
}
