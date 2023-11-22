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
    @Binding var textFieldColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(textFieldColor, lineWidth: 1)
                .foregroundColor(.designSystem(.pureWhite))
                .frame(height: 56)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 16,
                        bottom: 0,
                        trailing: 16
                    )
                )
            
            SecureField(
                "비밀번호",
                text: $password,
                prompt: Text("비밀번호를 입력해주세요").foregroundColor(.designSystem(.ivoryGray500))
            )
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
