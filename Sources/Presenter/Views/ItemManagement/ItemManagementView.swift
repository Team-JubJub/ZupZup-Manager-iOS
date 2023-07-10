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
    
    @StateObject var itemManageStore: ItemManageStore
    
    let columns = [GridItem(), GridItem()]
    
    var body: some View {
        VStack(spacing: 0) {
            if itemManageStore.isLoading {
                RoundCircleProgress()
            } else {
                HStack(spacing: 0) {
                    LargeNavigationTitle(title: "제품 관리")
                    InfiniteSpacer()
                    EditButton { itemManageStore.reduce(action: .tabEditButton) }
                        .confirmationDialog(
                            "Title",
                            isPresented: $itemManageStore.isEditable
                        ) {
                            Button("수량 수정") { itemManageStore.reduce(action: .tapEditCountButton) }
                            Button("제품 정보 수정") { itemManageStore.reduce(action: .tapEditInfoButton) }
                            Button("제품 추가") { itemManageStore.reduce(action: .tapAddItemButton) }
                            Button("취소", role: .cancel) {}
                        }
                        .navigationDestination(isPresented: $itemManageStore.isEditCountVisible) {
                            EditItemCountView(itemManageStore: itemManageStore)
                        }
                        .navigationDestination(isPresented: $itemManageStore.isAddItemVisible) {
                            
                        }
                        .navigationDestination(isPresented: $itemManageStore.isEditInfoVisible) {
                            Text("정보 수정")
                        }
                        
                }
                .padding(EdgeInsets(top: 46, leading: Device.HPadding, bottom: Device.Height * 20 / 844, trailing: Device.HPadding))
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(itemManageStore.store.items.indices, id: \.self) { idx in
                            ProductGridItem(
                                isEditable: $itemManageStore.isEditable,
                                count: $itemManageStore.store.items[idx].amount,
                                url: $itemManageStore.store.items[idx].imageUrl,
                                title: $itemManageStore.store.items[idx].name,
                                originalPrice: $itemManageStore.store.items[idx].priceOrigin,
                                salePrice: $itemManageStore.store.items[idx].priceDiscount,
                                type: .common,
                                minusAction: { itemManageStore.reduce(action: .tabMinusButton, idx: idx) },
                                plusAction: { itemManageStore.reduce(action: .tabPlusButton, idx: idx) }
                            )
                        }
                    }
                    .frame(width: Device.WidthWithPadding)
                }
            }
        }
        .navigationTitle("")
    }
}
