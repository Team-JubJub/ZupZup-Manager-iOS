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
                
                NavigationBarWithDismiss(label: "이전으로")
                
                VSpacer(height: Device.Height * 2 / 844)
                
                HStack(spacing: 0) {
                    LargeNavigationTitle(title: "예약")
                    InfiniteSpacer()
                    if store.reservation.state != .new { StateCapsule(state: $store.reservation.state) }
                }
                .frame(width: Device.WidthWithPadding, height: 43)
                
                HStack(spacing: 0) {
                    SuitLabel(text: store.reservation.date, typo: .subhead, color: .designSystem(.ivoryGray300))
                    InfiniteSpacer()
                }
                .frame(width: Device.WidthWithPadding)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        VSpacer(height: Device.Height * 26 / 844)
                        
                        SuiteLabel(text: "주문자 정보", typo: .h3)
                        
                        VSpacer(height: Device.Height * 32 / 844)
                        
                        ReserveInfoView(
                            customer: store.reservation.customerName,
                            phoneNumber: store.reservation.phoneNumber,
                            arrivedTime: store.reservation.orderedTime
                        )
                        
                        VSpacer(height: Device.Height * 48 / 844)
                        
                        SuiteLabel(text: "주문 내역", typo: .h3)
                        
                        VSpacer(height: Device.Height * 21 / 844)
                        
                        VStack(spacing: 8) {
                            ForEach(store.reservation.cartList.indices, id: \.self) { idx in
                                OrderItem(
                                    itemName: $store.reservation.cartList[idx].name,
                                    price: $store.reservation.cartList[idx].salesPrice,
                                    count: $store.reservation.cartList[idx].amount,
                                    state: $store.reservation.state,
                                    minusAction: { store.reduce(action: .tabMinusButton, idx: idx) },
                                    plusAction: { store.reduce(action: .tabPlusButton, idx: idx) }
                                )
                            }
                        }
                    }
                    .frame(width: Device.Width * 358 / 390)
                }
                .navigationTitle("")
                .navigationBarHidden(true)
                
                switch store.reservation.state {
                case .new:
                    BottomButton(
                        height: 56,
                        text: "예약 확정하기",
                        textColor: .designSystem(.pureWhite)!
                    ) {
                        store.reduce(action: .tabCheckButton)
                    }
                    .padding(
                        EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: Device.VPadding / 2,
                            trailing: 0
                        )
                    )
                case .confirm:
                    HStack(spacing: Device.HPadding) {
                        Button {
                            store.reduce(action: .tabCancelButton)
                        } label: {
                            HalfSquareButton(
                                backgroundColor: .neutralGray150,
                                fontColor: .neutralGray400,
                                title: "취소"
                            )
                            .frame(height: 56)
                            .padding(EdgeInsets(top: 0, leading: Device.HPadding, bottom: 0, trailing: 0))
                        }
                        
                        Button {
                            store.reduce(action: .tabCompleteButton)
                        } label: {
                            HalfSquareButton(
                                backgroundColor: .Tangerine300,
                                fontColor: .pureBlack,
                                title: "완료"
                            )
                            .frame(height: 56)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.HPadding))
                        }
                    }
                    .frame(height: 96)
                default:
                    EmptyView()
                }
            }
            .sheet(isPresented: $store.isChecked) {
                ConfirmBottomSheet(store: store)
                    .presentationDetents([.medium])
            }
        }
    }
}
