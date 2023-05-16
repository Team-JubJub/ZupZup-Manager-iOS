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
            VSpacer(height: Device.Height * 47 / 844)
            
            HStack(spacing: 0) {
                LargeTitleLabel(title: manageStore.isEditable ? "관리" : "제품 관리")
                    .padding(Device.HPadding)
                Spacer()
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    VSpacer(height: Device.Height * 55 / 844)
                    
                    SecondSubTitleLabel(title: "가게 관리")
                    
                    StoreInfoView(
                        store: manageStore.store?.name ?? "",
                        event: manageStore.store?.event ?? "",
                        time: manageStore.store?.time ?? ""
                    )
                    
                    VSpacer(height: Device.Height * 62 / 844)
                    
                    HStack(spacing: 0) {
                        SecondSubTitleLabel(title: "제품 관리")
                        Spacer()
                        Button {
                            manageStore.reduce(action: .tabEditButton)
                        } label: {
                            EditButton()
                        }
                    }
                    
                    VSpacer(height: Device.Height * 24 / 844)
                    
                    VStack(spacing: 8) {
                        ForEach(manageStore.store?.item ?? [], id: \.self) { item in
                            NavigationLink {
                                ItemView()
                            } label: {
                                MyProductItem(
                                    isEditable: $manageStore.isEditable,
                                    count: item.amount,
                                    url: item.imageUrl,
                                    title: item.name,
                                    originalPrice: item.priceOrigin,
                                    salePrice: item.priceDiscount
                                )
                            }
                        }
                    }
                }
                .navigationTitle("")
            }
            
            if manageStore.isEditable {
                Button {
                    manageStore.reduce(action: .tabEditBottom)
                } label: {
                    BottomButton(
                        height: 67,
                        text: "수정하기",
                        textColor: .designSystem(.OffWhite)!
                    )
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
