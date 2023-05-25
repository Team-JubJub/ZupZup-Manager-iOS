//
//  ManageView.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ManageView: View {
    
    @StateObject var manageStore: ManageStore
    
    var body: some View {
        VStack(spacing: 0) {
            if manageStore.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
            } else {
                VSpacer(height: Device.Height * 47 / 844)
                
                HStack(spacing: 0) {
                    LargeTitleLabel(title: manageStore.isEditable ? "관리" : "제품 관리")
                        .padding(Device.HPadding)
                    Spacer()
                    if manageStore.isEditable {
                        NavigationLink {
                            AddItemView(addItemStore: AddItemStore(itemId: manageStore.store.items.count, manageStore: manageStore))
                        } label: {
                            Image(assetName: .ic_plus_orange)
                                .resizable()
                                .frame(
                                    width: 24,
                                    height: 24
                                )
                                .padding(
                                    EdgeInsets(
                                        top: 0,
                                        leading: 0,
                                        bottom: 0,
                                        trailing: Device.Width * 28 / 390
                                    )
                                )
                        }
                    }
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        VSpacer(height: Device.Height * 55 / 844)
                        
                        SecondSubTitleLabel(title: "가게 관리")
                        
                        StoreInfoView(
                            store: manageStore.store.name,
                            event: manageStore.store.event,
                            time: manageStore.store.time
                        )
                        
                        VSpacer(height: Device.Height * 62 / 844)
                        
                        HStack(spacing: 0) {
                            SecondSubTitleLabel(title: "제품 관리")
                            Spacer()
                            
                            if !manageStore.isEditable {
                                EditButton {
                                    manageStore.reduce(action: .tabEditButton)
                                }
                            }
                        }
                        
                        VSpacer(height: Device.Height * 24 / 844)
                        
                        VStack(spacing: 8) {
                            ForEach(manageStore.store.items.indices, id: \.self) { idx in
                                if manageStore.isEditable {
                                    NavigationLink {
                                        let itemStore = ItemStore(item: manageStore.store.items[idx], manageStore: manageStore)
                                        ItemView(itemStore: itemStore)
                                    } label: {
                                        MyProductItem(
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
                                } else {
                                    MyProductItem(
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
                        }
                    }
                    .navigationTitle("")
                }
                
                if manageStore.isEditable {
                    BottomButton(height: 67, text: "수정완료", textColor: .designSystem(.OffWhite)!) {
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
    }
}
