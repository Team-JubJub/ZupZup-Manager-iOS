//
//  ReservationDetailView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ReserveDetailView: View {
    
    @StateObject var store: ReservationDetailStore
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        UnderTitleLabel(timeString: store.reservation.date)
                        
                        VSpacer(height: Device.Height * 30 / 844)
                        
                        SubTitleLabel(subtitle: "주문 정보")
                        
                        VSpacer(height: Device.Height * 32 / 844)
                        
                        ReserveInfoView(
                            customer: store.reservation.customerName,
                            phoneNumber: store.reservation.phoneNumber,
                            arrivedTime: store.reservation.orderedTime
                        )
                        
                        VSpacer(height: Device.Height * 48 / 844)
                        
                        SubTitleLabel(subtitle: "주문 내역")
                        
                        VSpacer(height: Device.Height * 21 / 844)
                        
                        VStack(spacing: 8) {
                            ForEach(store.reservation.cartList, id: \.self) { item in
                                OrderItem(
                                    itemName: item.name,
                                    price: "\(item.salesPrice)원",
                                    count: item.amount
                                )
                            }
                        }
                    }
                    .frame(width: Device.Width * 358 / 390)
                }
                .navigationTitle("사이즈한도테스트테스트테스")
                
                Button {
                    // TODO: Bottom sheet Tigger
                    store.reduce(action: .tabCheckButton)
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
            .sheet(isPresented: $store.isChecked) {
                ConfirmBottomSheet()
                    .presentationDetents([.medium])
            }
        }
    }
}
