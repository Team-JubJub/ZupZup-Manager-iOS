//
//  ReservationDetailView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct ReserveDetailView: View {
    
    let store: Store<ReservationDetailState, ReservationDetailAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                VStack(spacing: 0) {
                    
                    NavigationBarWithDismiss(label: "이전으로")
                    
                    VSpacer(height: Device.Height * 2 / 844)
                    
                    HStack(spacing: 0) {
                        LargeNavigationTitle(title: "예약")
                        InfiniteSpacer()
                        if viewStore.reservation.state != .new { StateCapsule(state: viewStore.reservation.state) }
                    }
                    .frame(width: Device.WidthWithPadding, height: 43)
                    
                    HStack(spacing: 0) {
                        SuitLabel(text: viewStore.reservation.date, typo: .subhead, color: .designSystem(.ivoryGray300))
                        InfiniteSpacer()
                    }
                    .frame(width: Device.WidthWithPadding)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 0) {
                            VSpacer(height: Device.Height * 26 / 844)
                            
                            SuiteLabel(text: "주문자 정보", typo: .h3)
                            
                            VSpacer(height: Device.Height * 32 / 844)
                            
                            ReserveInfoView(
                                customer: viewStore.reservation.customerName,
                                phoneNumber: viewStore.reservation.phoneNumber,
                                arrivedTime: viewStore.reservation.orderedTime
                            )
                            
                            VSpacer(height: Device.Height * 48 / 844)
                            
                            SuiteLabel(text: "주문 내역", typo: .h3)
                            
                            VSpacer(height: Device.Height * 21 / 844)
                            
                            VStack(spacing: 8) {
                                ForEach(viewStore.reservation.cartList.indices, id: \.self) { idx in
                                    OrderItem(
                                        itemName: viewStore.reservation.cartList[idx].name,
                                        price: viewStore.reservation.cartList[idx].price,
                                        count: viewStore.reservation.cartList[idx].amount,
                                        state: viewStore.reservation.state,
                                        minusAction: { viewStore.send(.tabMinusButton(idx)) },
                                        plusAction: { viewStore.send(.tabPlusButton(idx)) }
                                    )
                                }
                            }
                        }
                        .frame(width: Device.Width * 358 / 390)
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    
                    switch viewStore.reservation.state {
                    case .new:
                        BottomButton(
                            height: 56,
                            text: "예약 확정하기",
                            textColor: .designSystem(.pureWhite)!
                        ) {
                            viewStore.send(.tabBottomButton)
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
                                viewStore.send(.tabCancelButton)
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
                                viewStore.send(.tabCompleteButton)
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
                .sheet(isPresented: viewStore.binding(get: \.isShowingHalfModal, send: ReservationDetailAction.bindIsShowingHalfModal)) {
                    ConfirmBottomSheet(store: store)
                        .presentationDetents([.medium])
                }
            }
        }
    }
}
