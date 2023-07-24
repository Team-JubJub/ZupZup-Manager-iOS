//
//  EditItemInfoView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/11.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct EditItemInfoView: View {
    
    let store: Store<EditItemInfoState, EditItemInfoAction>
    
    let columns = [GridItem(), GridItem()]
    
    var body: some View {
        
        WithViewStore(store) { viewStore in
            ZStack {
                VStack(spacing: 0) {
                    NavigationBarWithDismiss(label: "제품 관리")
                    
                    HStack(spacing: 0) {
                        LargeNavigationTitle(title: "정보 수정")
                        InfiniteSpacer()
                    }
                    .padding(EdgeInsets(top: 2, leading: Device.HPadding, bottom: Device.Height * 20 / 844, trailing: Device.HPadding))
                    
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns) {
                            ForEach(viewStore.state.items.indices, id: \.self) { idx in
                                Button {
                                    viewStore.send(.tapGridItem)
                                } label: {
                                    ProductGridItem(
                                        count: viewStore.state.items[idx].amount,
                                        url: viewStore.items[idx].imageUrl,
                                        title: viewStore.state.items[idx].name,
                                        originalPrice: viewStore.state.items[idx].priceOrigin,
                                        salePrice: viewStore.state.items[idx].priceDiscount,
                                        type: .editInfo
                                    )
                                }
                                .navigationDestination(
                                    isPresented: viewStore.binding(
                                        get: { $0.isShowingDetail },
                                        send: EditItemInfoAction.dismissIsShowingDetail
                                    )
                                ) {
                                    EmptyView()
//                                    EditItemInfoDetailView(store: EditItemDetailStore(item: itemStore.items[idx]))
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        .frame(width: Device.WidthWithPadding)
                        
                        VSpacer(height: 64)
                    }
                    VSpacer(height: 50)
                }
                
                VStack(spacing: 0) {
                    InfiniteSpacer()
                    BottomButton(height: 64, text: "수정 완료", textColor: .designSystem(.pureBlack)!) {
                        viewStore.send(.tapBottomButton)
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("")
        }
    }
}
