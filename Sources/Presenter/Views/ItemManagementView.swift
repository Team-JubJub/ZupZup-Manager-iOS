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
                        ForEach(manageStore.store.items, id: \.self) { item in
                            VStack(spacing: 0) {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.designSystem(.ivoryGray200)!, lineWidth: 1)
                                    .overlay {
                                        VStack(spacing: 0) {
                                            KFImage(URL(string: item.imageUrl))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: Device.Width * 175 / 390, height: 110)
                                                .clipped()
                                            
                                            VStack(spacing: 0) {
                                                HStack(spacing: 0) {
                                                    SuiteLabel(text: item.name, typo: .headline)
                                                        .lineLimit(2)
                                                    InfiniteSpacer()
                                                }
                                                
                                                InfiniteSpacer()
                                                
                                                HStack(spacing: 0) {
                                                    SuiteLabel(text: "\(item.priceDiscount)원", typo: .headline, color: .designSystem(.Tangerine300))
                                                    InfiniteSpacer()
                                                    SuitLabel(text: item.amount == 0 ? "품절" : item.amount.toString() + "개", typo: .subhead, color: .designSystem(.ivoryGray400))
                                                }
                                            }
                                            .padding(Device.VPadding / 2)
                                        }
                                        .cornerRadius(8)
                                    }
                                    .frame(width: Device.Width * 175 / 390, height: 200)
                                    .background(Color.designSystem(.ivoryGray100).cornerRadius(9))
                            }
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
