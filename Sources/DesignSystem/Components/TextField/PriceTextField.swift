//
//  RectangleWithTwoLabel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/07.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct PriceTextField: View {
    
    @Binding var rightText: String
    
    var body: some View {
        IvoryRoundedRectangle(width: Device.WidthWithPadding, height: 56)
            .overlay {
                ZStack {
                    HStack(spacing: 0) {
                        InfiniteSpacer()
                        SuiteLabel(text: "₩" + rightText.toPrice(), typo: .h3)
                        InfiniteSpacer()
                    }
                    TextField("", text: $rightText)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .font(Suite(weight: .heavy, size: ._20))
                        .foregroundColor(.clear)
                        .background(Color.clear)
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: CGFloat(30 + (rightText.count / 4) * 3),
                                bottom: 0,
                                trailing: 0
                            )
                        )
                }
            }
    }
}
