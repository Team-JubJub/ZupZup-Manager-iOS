//
//  ManageView.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ItemManagementView: View {
    
    @StateObject var manageStore: ManageStore
    
    let columns = [GridItem(), GridItem()]
    
    var body: some View {
        VStack(spacing: 0) {
            if manageStore.isLoading {
                RoundCircleProgress()
            } else {
                HStack(spacing: 0) {
                    LargeNavigationTitle(title: "제품 관리")
                    InfiniteSpacer()
                }
                .padding(EdgeInsets(top: 46, leading: Device.HPadding, bottom: Device.Height * 20 / 844, trailing: Device.HPadding))
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(manageStore.store.items.indices, id: \.self) { idx in
                            ProductGridItem(
                                isEditable: $manageStore.isEditable,
                                count: $manageStore.store.items[idx].amount,
                                url: $manageStore.store.items[idx].imageUrl,
                                title: $manageStore.store.items[idx].name,
                                originalPrice: $manageStore.store.items[idx].priceOrigin,
                                salePrice: $manageStore.store.items[idx].priceDiscount,
                                minusAction: { manageStore.reduce(action: .tabMinusButton, idx: idx) },
                                plusAction: { manageStore.reduce(action: .tabPlusButton, idx: idx) }
                            )
                        }
                    }
                    .frame(width: Device.WidthWithPadding)
                }
                
                if manageStore.isEditable {
                    BottomButton(height: 67, text: "수정완료", textColor: .designSystem(.pureWhite)!) {
                        manageStore.reduce(action: .tabEditBottomButton)
                    }
                    .padding(
                        EdgeInsets(
                            top: Device.VPadding / 2,
                            leading: 0,
                            bottom: 0,
                            trailing: 0
                        )
                    )
                }
            }
        }
        .navigationTitle("")
    }
}
