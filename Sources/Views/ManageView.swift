//
//  ManageView.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ManageView: View {
    
    @State var isEditable: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            VSpacer(height: Device.Height * 47 / 844)
            
            HStack(spacing: 0) {
                LargeTitleLabel(title: isEditable ? "관리" : "제품 관리")
                    .padding(Device.HPadding)
                Spacer()
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    VSpacer(height: Device.Height * 55 / 844)
                    
                    SecondSubTitleLabel(title: "가게 관리")
                    
                    StoreInfoView(
                        store: "맥도날드",
                        event: "현금결제시 500원 할인",
                        time: "19:00 ~ 19:20"
                    )
                    
                    VSpacer(height: Device.Height * 62 / 844)
                    
                    HStack(spacing: 0) {
                        SecondSubTitleLabel(title: "제품 관리")
                        
                        Spacer()
                        
                        // TODO: TCA 적용해야함
                        Button {
                            withAnimation { self.isEditable = true }
                        } label: {
                            EditButton()
                        }
                    }
                    
                    VSpacer(height: Device.Height * 24 / 844)
                    
                    VStack(spacing: 8) {
                        ForEach(0..<8) { _ in
                            MyProductItem(
                                isEditable: $isEditable,
                                count: 8,
                                title: "제품명",
                                originalPrice: 3000,
                                salePrice: 2400
                            )
                        }
                    }
                }
                .navigationTitle("")
            }
            
            if isEditable {
                // TODO: 수정해야함
                Button {
                    withAnimation { self.isEditable = false }
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
