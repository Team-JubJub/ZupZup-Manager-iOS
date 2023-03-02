//
//  passwordTextField.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/01.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct PasswordTextField: View {
    
    @Binding var password: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(14)
                .foregroundColor(.designSystem(.zupzupWarmGray1))
                .frame(height: 56)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 24,
                        bottom: 0,
                        trailing: 24
                    )
                )
            HStack(spacing: 0) {
                TextField("비밀번호", text: $password)
                Image(assetName: .ic_eye)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 42,
                    bottom: 0,
                    trailing: 36
                )
            )
        }
    }
}
