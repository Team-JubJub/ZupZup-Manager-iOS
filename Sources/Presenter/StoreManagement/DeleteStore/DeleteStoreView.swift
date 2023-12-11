//
//  DeleteStoreView.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/07.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct DeleteStoreView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var store: Store<DeleteStoreState, DeleteStoreAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 0) {
                NavigationBarWithDismiss(label: "설정")
                
                HStack(spacing: 0) {
                    SuiteLabel(text: "줍줍과 이별하기", typo: .hero, color: .designSystem(.Secondary))
                    InfiniteSpacer()
                }
                .padding(EdgeInsets(top: 23, leading: Device.HPadding, bottom: Device.Height * 20 / 844, trailing: Device.HPadding))
                
                ZStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 0) {
                            SuiteLabel(text: "\(viewStore.name)님\n...이별인가요? 너무 아쉬워요...", typo: .h3, color: .designSystem(.Secondary))
                            InfiniteSpacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding, trailing: 0))
                        
                        SuiteLabel(text: "그 동안 줍줍을 이용해주신 \(viewStore.name)님께 감사해요. 덕분에 이 세상에서 낭비되는 가치를 많이 줄일 수 있었어요.", typo: .subhead, color: .designSystem(.Secondary))
                            .padding(EdgeInsets(top: 0, leading: Device.HPadding / 2, bottom: Device.VPadding / 2, trailing: Device.HPadding / 2))
                            
                        SuiteLabel(text: "계정을 삭제하면, 제품 목록, 가게 정보, 계정 정보 및 모든 활동 정보가 삭제 되어요. 또한, 계정 삭제 후 7일 간 다시 가입할 수 없어요. ", typo: .subhead, color: .designSystem(.Secondary))
                            .padding(EdgeInsets(top: 0, leading: Device.HPadding / 2, bottom: 0, trailing: Device.HPadding / 2))
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: Device.HPadding, bottom: 0, trailing: Device.HPadding))
                }
                
                InfiniteSpacer()
                
                Image(assetName: .ic_goodbye)
                    .resizable()
                    .frame(width: Device.Width * 0.7, height: Device.Width * 0.7)
                    .scaledToFit()

                BottomButton(height: 64, text: "정말 이별하기", textColor: .secondary) {
                    viewStore.send(.tapBottomButton)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding, trailing: 0))
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .onChange(of: viewStore.isPop) { isPop in
                if isPop { dismiss() }
            }
            .alert(
                viewStore.errorTitle,
                isPresented: viewStore.binding(get: {$0.isErrorOn}, send: DeleteStoreAction.isErrorDismiss),
                actions: {
                    Button("확인", role: .cancel) { }
                },
                message: { Text(viewStore.errorMessage) }
            )
            .alert(
                "회원 탈퇴하기",
                isPresented: viewStore.binding(get: { $0.isShowingAlert }, send: DeleteStoreAction.dismissAlert),
                actions: {
                    Button("네", role: .destructive) { viewStore.send(.tabAlertOk) }
                    Button("아니오", role: .cancel) { }
                },
                message: { Text("정말 회원 탈퇴하시나요?") }
            )
            
        }
    }
}
