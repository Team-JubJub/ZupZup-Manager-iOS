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
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 0) {
                            SuitLabel(
                                text: "아이디 혹은 비밀번호를 다시 확인해주세요.\n5번 이상 잘못된 입력을 하실 경우 이용이 제한됩니다. (1/5)",
                                typo: .caption,
                                color: .designSystem(.red500)
                            )
                            InfiniteSpacer()
                        }
//                        Spacer()
                    }
                    .frame(width: Device.WidthWithPadding, height: 30)
                    .padding(
                        EdgeInsets(
                            top: Device.Height * 16 / 844,
                            leading: 0,
                            bottom: Device.Height * 24 / 844,
                            trailing: 0
                        )
                    )
                    
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
                            SystemLabel(text: "내 계정 찾기", typo: .caption, color: .designSystem(.ivoryGray500))
                                .frame(width: 64)
                            
                        }
                        
                        Rectangle()
                            .frame(width: 1, height: 16)
                            .foregroundColor(.designSystem(.ivoryGray300))
                        
                        Button {
                            // TODO: 내 계정 찾기
                        } label: {
                            HStack(spacing: 0) {
                                SystemLabel(text: "회원가입", typo: .caption, color: .designSystem(.ivoryGray500))
                                InfiniteSpacer()
                            }
                        }
                        .frame(width: 64)
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
