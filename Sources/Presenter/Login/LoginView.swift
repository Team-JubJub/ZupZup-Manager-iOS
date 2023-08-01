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
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
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
                    
                    VSpacer(height: Device.Height * 69 / 844)
                    
                    HStack(spacing: 5) {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.designSystem(.ivoryGray300))
                        
                        SuitLabel(text: "또는", typo: .caption, color: .designSystem(.ivoryGray300))
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.designSystem(.ivoryGray300))
                    }
                    .frame(width: Device.WidthWithPadding)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 14, trailing: 0))
                    
                    HStack(spacing: 8) {
                        Button {
                            // TODO: 내 계정 찾기
                        } label: {
                            SystemLabel(text: "내 계정 찾기", typo: .caption, color: .designSystem(.ivoryGray300))
                        }
                        
                        Rectangle()
                            .frame(width: 1, height: 16)
                            .foregroundColor(.designSystem(.ivoryGray300))
                        
                        Button {
                            // TODO: 내 계정 찾기
                        } label: {
                            SystemLabel(text: "회원가입", typo: .caption, color: .designSystem(.ivoryGray300))
                        }
                    }
                    
                    VSpacer(height: Device.Height * 56 / 844)
                    
                }
                .background(Color.designSystem(.pureWhite))
                .onTapGesture {
                    viewStore.send(.tapEmptySpace)
                }
                
                if viewStore.isLoading {
                    FullScreenProgressView()
                }
            }
            .ignoresSafeArea()
        }
    }
}
