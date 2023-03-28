//
//  LoginView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/27.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var isLogin: Bool
    
    @State var idString: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            BoxImage()
            Spacer()
            
            IdTextField(idString: $idString)
            VSpacer(height: 20)
            PasswordTextField(password: $password)
            Spacer()
            
            Button {
                print("button tabbed")
                // TODO: fix
                self.isLogin.toggle()
            } label: {
                BottomButton(
                    height: 57,
                    text: "로그인",
                    textColor: .designSystem(.Secondary)!
                )
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
}
