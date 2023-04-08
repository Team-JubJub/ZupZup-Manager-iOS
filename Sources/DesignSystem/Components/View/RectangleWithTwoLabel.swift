//
//  RectangleWithTwoLabel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/07.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct RectangleWithTwoLabel: View {
    
    let leftText: String
    let rightText: String
    
    var body: some View {
        Rectangle()
            .frame(width: Device.WidthWithPadding, height: 53)
            .cornerRadius(14)
            .foregroundColor(.designSystem(.zupzupWarmGray3))
            .overlay {
                HStack(spacing: 0) {
                    Text(leftText)
                        .font(SystemFont(size: ._17, weight: .semibold))
                        .foregroundColor(.designSystem(.Secondary))
                        .padding(EdgeInsets(top: 0, leading: Device.HPadding, bottom: 0, trailing: 0))
                    
                    Spacer()
                    
                    Text(rightText)
                        .font(SystemFont(size: ._17, weight: .regular))
                        .foregroundColor(.designSystem(.Secondary))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.HPadding))
                }
            }
    }
}
