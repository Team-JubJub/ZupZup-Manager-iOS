//
//  RectangleWithTwoButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct RectangleWithTwoButton: View {
    
    let text: String
    
    let minusButtonAction: () -> Void
    let plusButtonAction: () -> Void
    
    var body: some View {
        Rectangle()
            .frame(width: Device.WidthWithPadding, height: 53)
            .cornerRadius(14)
            .foregroundColor(.designSystem(.zupzupWarmGray3))
            .overlay {
                HStack(spacing: 0) {
                    Text(text)
                        .font(SystemFont(size: ._17, weight: .semibold))
                        .foregroundColor(.designSystem(.Secondary))
                        .padding(EdgeInsets(top: 0, leading: Device.HPadding, bottom: 0, trailing: 0))
                    Spacer()
                    
                    HStack(spacing: Device.HPadding) {
                        MinusButton(palette: .zupzupWarmGray6) {
                            minusButtonAction()
                        }

                        Text("1")
                            .foregroundColor(.designSystem(.Secondary))
                            .font(SystemFont(size: ._17, weight: .regular))
                        PlusButton(palette: .zupzupWarmGray6) {
                            plusButtonAction()
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.HPadding))
                }
            }
    }
}
