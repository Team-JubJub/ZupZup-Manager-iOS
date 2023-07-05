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
                
                NavigationBarWithDismiss(label: "예약상황")
                VSpacer(height: Device.Height * 2 / 844)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Group {
                            HStack(spacing: 0) {
                                LargeTitleLabel(title: store.reservation.orderedItemdName)
                                Spacer()
                                StateCapsule(state: $store.reservation.state)
                            }
                            .frame(height: 43)
                            VSpacer(height: 2)
                            UnderTitleLabel(timeString: store.reservation.date)
                        }
                        
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
                        height: 64,
                        text: "예약 확인하기",
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
                            .frame(height: 64)
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
                            .frame(height: 64)
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
