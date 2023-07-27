//
//  StoreIntroduceView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct StoreIntroduceView: View {
    
    let store: Store<StoreIntroduceState, StoreIntroduceAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    InfiniteSpacer()
                    SuiteLabel(text: "가게 소개", typo: .headline)
                    InfiniteSpacer()
                }
                .frame(height: 42)
                .padding(EdgeInsets(top: 24, leading: 0, bottom: 46, trailing: 0))
                
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.designSystem(.ivoryGray500)!, lineWidth: 1)
                        .foregroundColor(.designSystem(.pureWhite))
                        .overlay {
                            TextEditor(
                                text: viewStore.binding(
                                    get: { $0.introduceText },
                                    send: StoreIntroduceAction.textFieldChanged
                                )
                            )
                            .cornerRadius(8)
                            .font(Suit(weight: .regular, size: ._17))
                            .lineSpacing(3)
                        }
                        .frame(width: Device.WidthWithPadding, height: 300)
                    
                    HStack(spacing: 0) {
                        InfiniteSpacer()
                        SuiteLabel(text: viewStore.introduceText.count.toString(), typo: .subhead, color: .designSystem(.Tangerine300))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                        SuiteLabel(text: "/", typo: .subhead, color: .designSystem(.Tangerine300))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                        SuiteLabel(text: "300", typo: .subhead, color: .designSystem(.Tangerine300))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                    }
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                }
                .frame(width: Device.WidthWithPadding)
                
                InfiniteSpacer()
                
                BottomButton(
                    height: 64,
                    text: "수정 완료",
                    textColor: .designSystem(.pureBlack)!
                ) {
                    viewStore.send(.tapBottomButton)
                }
            }
            .alert(
                "가게 소개 수정",
                isPresented: viewStore.binding(
                    get: { $0.isShowingAlert },
                    send: StoreIntroduceAction.dismissAlert
                ),
                actions: {
                    Button("확인", role: .none) { viewStore.send(.tapAlertOk) }
                    Button("취소", role: .cancel) { viewStore.send(.tapAlertCancel) }
                },
                message: { Text("가게 소개글을 수정할까요?") }
            )
        }
    }
}
