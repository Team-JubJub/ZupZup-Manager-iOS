//
//  EditItemCountView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/10.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct EditItemCountView: View {
    
    @StateObject var itemManageStore: ItemManageStore
    
    let columns = [GridItem(), GridItem()]
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBarWithDismiss(label: "제품 관리")
            
            HStack(spacing: 0) {
                LargeNavigationTitle(title: "수량 수정")
                InfiniteSpacer()
            }
            .padding(EdgeInsets(top: 2, leading: Device.HPadding, bottom: Device.Height * 20 / 844, trailing: Device.HPadding))
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(itemManageStore.store.items.indices, id: \.self) { idx in
                        ProductGridItem(
                            count: $itemManageStore.store.items[idx].amount,
                            url: $itemManageStore.store.items[idx].imageUrl,
                            title: $itemManageStore.store.items[idx].name,
                            originalPrice: $itemManageStore.store.items[idx].priceOrigin,
                            salePrice: $itemManageStore.store.items[idx].priceDiscount,
                            type: .editCount,
                            minusAction: { itemManageStore.reduce(action: .tabMinusButton, idx: idx) },
                            plusAction: { itemManageStore.reduce(action: .tabPlusButton, idx: idx) }
                        )
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                .frame(width: Device.WidthWithPadding)
            }
            
            VStack(spacing: 0) {
                VSpacer(height: 10)
                BottomButton(height: 64, text: "수정 완료", textColor: .designSystem(.pureBlack)!) {
                    itemManageStore.reduce(action: .tabEditBottomButton)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("")
    }
}
