//
//  passwordTextField.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/01.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct PasswordTextField: View {
    
    let action: () -> Void
    @Binding var password: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.designSystem(.zupzupIvoryGray500)!, lineWidth: 1)
                .foregroundColor(.designSystem(.OffWhite))
                .frame(height: 56)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 16,
                        bottom: 0,
                        trailing: 16
                    )
                )
            
            TextField(
                "비밀번호",
                text: $password,
                prompt: Text("비밀번호").foregroundColor(.designSystem(.zupzupIvoryGray500))
            )
            .submitLabel(.done)
            .onSubmit {
                action()
            }
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 32,
                    bottom: 0,
                    trailing: 32
                )
            )
        }
    }
}
