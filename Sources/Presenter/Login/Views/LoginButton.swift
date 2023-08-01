//
//  LoginButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/08/02.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct LoginButton: View {
    
    let height: CGFloat
    let text: String
    @Binding var textColor: Color
    @Binding var bodyColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Rectangle()
                    .cornerRadius(14)
                    .foregroundColor(bodyColor)
                    .frame(height: height)
                    .padding(
                        EdgeInsets(
                            top: 0,
                            leading: Device.HPadding,
                            bottom: 0,
                            trailing: Device.HPadding
                        )
                    )
                Text(text)
                    .font(SystemFont(size: ._17, weight: .bold))
                    .foregroundColor(textColor)
            }
        }
    }
}
