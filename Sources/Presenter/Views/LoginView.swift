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
            InfiniteSpacer()
            
            BoxHighlighted()
            
            InfiniteSpacer()
            
            IdTextField(idString: $store.id)
            
            VSpacer(height: 20)
            
            PasswordTextField(
                action: { store.reduce(action: .tapLoginButton) },
                password: $store.password
            )
            
            VSpacer(height: Device.Height * 128 / 844)
        }
        .background(Color.designSystem(.OffWhite))
        .onTapGesture {
            store.hideKeyboard()
        }
    }
}
