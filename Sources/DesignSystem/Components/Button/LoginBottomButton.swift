//
//  LoginBottomButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/01.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct LoginBottomButton: View {
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(14)
                .foregroundColor(.designSystem(.zupzupMain))
                .frame(height: 57)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: Device.HPadding,
                        bottom: 0,
                        trailing: Device.HPadding
                    )
                )
            Text("로그인")
                .font(SystemFont(size: ._17, weight: .bold))
                .foregroundColor(.designSystem(.Secondary))
        }
    }
}
