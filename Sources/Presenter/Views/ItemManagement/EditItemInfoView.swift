//
//  EditItemInfoView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/11.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct EditItemInfoView: View {
    
    @StateObject var itemStore: EditItemInfoStore
    
    let columns = [GridItem(), GridItem()]
    
    var body: some View {
        
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
                        ForEach(itemStore.items.indices, id: \.self) { idx in
                            Button {
                                itemStore.reduce(action: .tapGridItem)
                            } label: {
                                ProductGridItem(
                                    count: itemStore.items[idx].amount,
                                    url: itemStore.items[idx].imageUrl,
                                    title: itemStore.items[idx].name,
                                    originalPrice: itemStore.items[idx].priceOrigin,
                                    salePrice: itemStore.items[idx].priceDiscount,
                                    type: .editInfo
                                )
                            }
                            .navigationDestination(isPresented: $itemStore.isShowDetail) {
                                EditItemInfoDetailView(store: EditItemDetailStore(item: itemStore.items[idx]))
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
                    itemStore.reduce(action: .tapBottomButton)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("")
    }
}
