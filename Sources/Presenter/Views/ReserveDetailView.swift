//
//  ReservationDetailView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ReserveDetailView: View {
    
    @State var isPresent: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        UnderTitleLabel()
                        
                        VSpacer(height: Device.Height * 30 / 844)
                        
                        SubTitleLabel(subtitle: "주문 정보")
                        
                        VSpacer(height: Device.Height * 32 / 844)
                        
                        ReserveInfoView(
                            customer: "김승창",
                            phoneNumber: "010-7777-7777",
                            arrivedTime: "19:00"
                        )
                        
                        VSpacer(height: Device.Height * 48 / 844)
                        
                        SubTitleLabel(subtitle: "주문 내역")
                        
                        VSpacer(height: Device.Height * 21 / 844)
                        
                        VStack(spacing: 8) {
                            ForEach(0..<10) { _ in
                                OrderItem(
                                    itemName: "초코 크로와상",
                                    price: "3000원",
                                    count: 5
                                )
                            }
                        }
                    }
                    .frame(width: Device.Width * 358 / 390)
                }
                .navigationTitle("사이즈한도테스트테스트테스")
                
                Button {
                    // TODO: Bottom sheet Tigger
                    withAnimation(.linear(duration: 1.0)) {
                        isPresent.toggle()
                    }
                    print("tabbed")
                } label: {
                    BottomButton(
                        height: 64,
                        text: "예약 확인하기",
                        textColor: .designSystem(.OffWhite)!
                    )
                    .padding(
                        EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: Device.VPadding / 2,
                            trailing: 0
                        )
                    )
                }
            }
            .sheet(isPresented: $isPresent) {
                ConfirmBottomSheet()
                    .presentationDetents([.medium])
            }
        }
    }
}
