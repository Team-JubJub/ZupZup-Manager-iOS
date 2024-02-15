//
//  EditItemCountView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/10.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct EditItemCountView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let store: StoreOf<EditItemCount>
    
    let columns = [GridItem(), GridItem()]
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 0) {
                NavigationBarWithDismiss(label: "제품 관리")
                
                HStack(spacing: 0) {
                    LargeNavigationTitle(title: "수량 수정")
                    InfiniteSpacer()
                }
                .padding(EdgeInsets(top: 2, leading: Device.HPadding, bottom: Device.Height * 20 / 844, trailing: Device.HPadding))
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(viewStore.items.indices, id: \.self) { idx in
                            ProductGridItem(
                                count: viewStore.state.items[idx].count,
                                url: viewStore.state.items[idx].imageUrl,
                                title: viewStore.state.items[idx].name,
                                originalPrice: viewStore.state.items[idx].priceOrigin,
                                salePrice: viewStore.state.items[idx].priceDiscount,
                                type: .editCount,
                                minusAction: { viewStore.send(.tapMinusAction(idx)) },
                                plusAction: { viewStore.send(.tapPlusAction(idx)) }
                            )
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    .frame(width: Device.WidthWithPadding)
                }
                
                VStack(spacing: 0) {
                    VSpacer(height: 10)
                    BottomButton(height: 64, text: "수정 완료", textColor: .designSystem(.pureBlack)!) {
                        viewStore.send(.tapBottomButton)
                    }
                }
            }
            .overlay {
                if viewStore.isLoading {
                    FullScreenProgressView()
                }
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("")
            .onChange(of: viewStore.isPop) { isPop in
                if isPop { dismiss() }
            }
            .alert(
                "수량 수정",
                isPresented: viewStore.binding(get: \.isShowingAlert, send: .dismissAlert),
                actions: {
                    Button("취소", role: .destructive) { viewStore.send(.alertCancelButton) }
                    Button("확인", role: .cancel) { viewStore.send(.alertOkButton) }
                },
                message: { Text("제품 수량 수정을 완료합니다.") }
            )
        }
    }
}
