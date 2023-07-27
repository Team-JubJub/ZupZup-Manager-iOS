//
//  LoginView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/27.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct LoginView: View {
    
    let store: Store<LoginState, LoginAction>
    
    @Binding var isLogin: Bool
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                VStack(spacing: 0) {
                    InfiniteSpacer()
                    
                    BoxHighlighted()
                    
                    InfiniteSpacer()
                    
                    IdTextField(
                        idString: viewStore.binding(
                            get: { $0.id },
                            send: LoginAction.idChanged
                        )
                    )
                    
                    VSpacer(height: 20)
                    
                    PasswordTextField(
                        password: viewStore.binding(
                            get: { $0.password },
                            send: LoginAction.passwordChanged
                        )
                    )
                    
                    BottomButton(
                        height: 56,
                        text: "로그인",
                        textColor: .designSystem(.neutralGray400)!
                    ) {
                        viewStore.send(.tapLoginButton)
                    }
                    .padding(
                        EdgeInsets(
                            top: 20,
                            leading: 0,
                            bottom: 0,
                            trailing: 0
                        )
                    )
                    
                    VSpacer(height: Device.Height * 128 / 844)
                }
                .background(Color.designSystem(.pureWhite))
                .onTapGesture {
                    viewStore.send(.tapEmptySpace)
                }
                
                if viewStore.isLoading {
                    LoginProgress()
                }
            }
            .ignoresSafeArea()
        }
    }
}
