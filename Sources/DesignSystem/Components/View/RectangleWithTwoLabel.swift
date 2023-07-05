//
//  RectangleWithTwoLabel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/07.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct RectangleWithTwoLabel: View {
    
    enum TextType {
        case text
        case number
    }
    
    let leftText: String
    @Binding var rightText: String
    
    let textType: TextType
    
    var body: some View {
        Rectangle()
            .frame(width: Device.WidthWithPadding, height: 53)
            .cornerRadius(14)
            .foregroundColor(.designSystem(.coolGray100))
            .overlay {
                HStack(spacing: 0) {
                    Text(leftText)
                        .font(SystemFont(size: ._17, weight: .semibold))
                        .foregroundColor(.designSystem(.pureBlack))
                        .padding(EdgeInsets(top: 0, leading: Device.HPadding, bottom: 0, trailing: 0))
                    
                    Spacer()
                    
                    switch textType {
                    case .text:
                        TextField(leftText, text: $rightText)
                            .multilineTextAlignment(.trailing)
                            .font(SystemFont(size: ._17, weight: .regular))
                            .foregroundColor(.designSystem(.pureBlack))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.HPadding))
                    case .number:
                        TextField(leftText, text: $rightText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .font(SystemFont(size: ._17, weight: .regular))
                            .foregroundColor(.designSystem(.pureBlack))
                        Text("원")
                            .font(SystemFont(size: ._17, weight: .regular))
                            .foregroundColor(.designSystem(.pureBlack))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.HPadding))
                        
                    }
                }
            }
    }
}
