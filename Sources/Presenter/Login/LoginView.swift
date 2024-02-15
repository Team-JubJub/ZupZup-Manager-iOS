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
    
    let store: StoreOf<Login>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                VStack(spacing: 0) {
                    InfiniteSpacer()
                    
                    ZupZupBox()
                    
                    InfiniteSpacer()
                    
                    IdTextField(
                        idString: viewStore.binding(get: \.id, send: { .idChanged($0) }),
                        textFieldColor: viewStore.binding(get: \.textFieldColor, send: .textFieldColorChanged)
                    )
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
                    PasswordTextField(
                        password: viewStore.binding(get: \.password, send: { .passwordChanged($0) }),
                        textFieldColor: viewStore.binding(get: \.textFieldColor, send: .textFieldColorChanged)
                    )
                    
                    LoginButton(
                        height: 56,
                        text: "로그인",
                        textColor: viewStore.binding(get: \.buttonTextColor, send: .buttonTextColorChanged),
                        bodyColor: viewStore.binding(get: \.buttonBodyColor, send: .buttonBodyColorChanged)
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
                        if viewStore.failCount != 0 {
                            HStack(spacing: 0) {
                                SuitLabel(
                                    text: "아이디 혹은 비밀번호를 다시 확인해주세요.\n5번 이상 잘못된 입력을 하실 경우 이용이 제한됩니다. (\(viewStore.failCount)/5)",
                                    typo: .caption,
                                    color: .designSystem(.red500)
                                )
                                InfiniteSpacer()
                            }
                        } else {
                            Spacer()
                        }
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
                    
                    HStack(spacing: 0) {
                        InfiniteSpacer()
                        
                        Button {
                            viewStore.send(.tapMakeAccount)
                        } label: {
                            SystemLabel(text: "회원가입", typo: .caption, color: .designSystem(.ivoryGray500))
                                .frame(width: 52)
                        }
                        
                        
                        InfiniteSpacer()
                        
                        Button {
                            viewStore.send(.tapFindMyAcoount)
                        } label: {
                            SystemLabel(text: "아이디 찾기", typo: .caption, color: .designSystem(.ivoryGray500))
                                .frame(width: 70)
                        }
                        
                        InfiniteSpacer()
                        
                        Button {
                            viewStore.send(.tapFindPassword)
                        } label: {
                            SystemLabel(text: "비밀번호 찾기", typo: .caption, color: .designSystem(.ivoryGray500))
                                .frame(width: 70)
                        }
                        
                        InfiniteSpacer()
                    }
                    .frame(width: Device.WidthWithPadding)
                    
                    VSpacer(height: Device.Height * 60 / 844)
                    
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
            .alert(
                viewStore.errorTitle,
                isPresented: viewStore.binding(get: \.isErrorOn, send: .isErrorDismiss),
                actions: { Button("확인", role: .cancel) { }},
                message: { Text(viewStore.errorMessage) }
            )
            .sheet(isPresented: viewStore.binding(get: \.isShowingFindMyAccountWeb, send: .dismissFindMyAcoount)) {
                SafariView(url: URL(string: UrlManager.findMyAccountUrl)!)
            }
            .sheet(isPresented: viewStore.binding(get: \.isShowingMakeAccountWeb, send: .dismissMakeAccount)) {
                SafariView(url: URL(string: UrlManager.makeAccountUrl)!)
            }
            .sheet(isPresented: viewStore.binding(get: \.isShowingFindPasswordWeb, send: .dismissFindPassword)) {
                SafariView(url: URL(string: UrlManager.findPasswordUrl)!)
            }
        }
    }
}
