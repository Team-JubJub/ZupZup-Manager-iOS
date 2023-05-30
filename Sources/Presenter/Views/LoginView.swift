//
//  LoginView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/27.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var store: LoginStore
    @Binding var isLogin: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            BoxImage()
            Spacer()
            
            IdTextField(idString: $store.id)
            VSpacer(height: 20)
            PasswordTextField(password: $store.password)
            Spacer()
            
            BottomButton(
                height: 57,
                text: "로그인",
                textColor: .designSystem(.Secondary)!
            ) {
                self.isLogin.toggle()
            }
            .padding(
                EdgeInsets(
                    top: Device.VPadding,
                    leading: 0,
                    bottom: Device.VPadding,
                    trailing: 0
                )
            )
        }
    }
}
