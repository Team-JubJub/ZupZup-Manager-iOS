//
//  ConfirmBottomSheet.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct ConfirmBottomSheet: View {

    let store: StoreOf<ReservationDetail>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewstore in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    SuiteLabel(text: "해당 주문을 확정할까요?", typo: .h3)
                    InfiniteSpacer()
                }
                .padding(EdgeInsets(top: Device.VPadding, leading: Device.HPadding, bottom: Device.VPadding / 2, trailing: 0))
                
                HStack(spacing: 0) {
                    SuitLabel(text: "아래 주문을 확인해주세요", typo: .caption)
                    InfiniteSpacer()
                }
                .padding(EdgeInsets(top: 0, leading: Device.HPadding, bottom: Device.VPadding, trailing: 0))
                
                Rectangle()
                    .foregroundColor(.designSystem(.SecondaryText))
                    .frame(width: Device.Width * 358 / 390, height: Device.Height * 97 / 844)
                    .cornerRadius(16)
                    .padding(EdgeInsets(top: 0, leading: Device.HPadding, bottom: 0, trailing: Device.HPadding))
                    .overlay {
                        HStack(spacing: 0) {
                            HStack(spacing: 0) {
                                VStack(spacing: 0) {
                                    RectangleWithIcon(assetName: .ic_user, color: .designSystem(.ivoryGray300)!)
                                    InfiniteSpacer()
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.HPadding / 2))
                                .frame(height: Device.Height * 65 / 844)
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    SuitLabel(text: "주문자", typo: .caption, color: .designSystem(.Tangerine300))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding * 5 / 16, trailing: 0))
                                    
                                    SuitLabel(text: viewstore.reservation.customerName, typo: .body)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding * 5 / 16, trailing: 0))
                                    
                                    SuitLabel(text: viewstore.reservation.phoneNumber, typo: .subhead, color: .designSystem(.ivoryGray300))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding * 5 / 16, trailing: 0))
                                    
                                    InfiniteSpacer()
                                }
                                .frame(height: Device.Height * 65 / 844)
                            }
                            
                            Spacer()
                            
                            VStack(spacing: 0) {
                                RectangleWithIcon(assetName: .ic_clock_white, color: .designSystem(.ivoryGray300)!)
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.HPadding / 2))
                            .frame(height: Device.Height * 65 / 844)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                SuitLabel(text: "방문 예정 시간", typo: .caption, color: .designSystem(.Tangerine300))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding * 5 / 16, trailing: 0))
                                
                                SuitLabel(
                                    text: viewstore.reservation.visitTime.formatDateTimeRange(),
                                    typo: .body
                                )
                                
                                InfiniteSpacer()
                            }
                            .frame(height: Device.Height * 65 / 844)
                        }
                        .frame(width: Device.Width * 326 / 390, height: Device.Height * 65 / 844)
                    }
                
                VSpacer(height: Device.VPadding)
                
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(.designSystem(.pureWhite))
                        .frame(width: Device.WidthWithPadding, height: Device.Height * 145 / 844)
                    
                    VStack {
                        InfiniteSpacer()
                        
                        HStack(spacing: 0) {
                            SuitLabel(text: "총 합계", typo: .subhead)
                            
                            InfiniteSpacer()
                            
                            SuiteLabel(text: ReservationHelper.makeTotalPrice(reservation: viewstore.reservation).toPrice(), typo: .h3, color: .designSystem(.Tangerine300))
                        }
                        
                        InfiniteSpacer()
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.designSystem(.ivoryGray150))
                        
                        InfiniteSpacer()
                        
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 0) {
                                ForEach(viewstore.reservation.cartList, id: \.self) { item in
                                    ConfirmBottomSheetItem(itemName: item.name, price: item.salePrice)
                                }
                            }
                        }
                    }
                    .frame(width: Device.Width * 326 / 390, height: Device.Height * 112 / 844)
                }
                
                VSpacer(height: Device.VPadding)
                
                HStack(spacing: 0) {
                    Button {
                        viewstore.send(.tabCancelButton)
                    } label: {
                        HalfSquareButton(
                            backgroundColor: .neutralGray150,
                            fontColor: .neutralGray400,
                            title: "취소"
                        )
                        .padding(EdgeInsets(top: 0, leading: Device.HPadding, bottom: 0, trailing: 0))
                    }
                    
                    HSpacer(width: Device.HPadding)
                    
                    Button {
                        viewstore.send(.tabConfirmButton)
                    } label: {
                        HalfSquareButton(
                            backgroundColor: .Tangerine300,
                            fontColor: .pureBlack,
                            title: "확정"
                        )
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.HPadding))
                    }
                }
            }
            .alert(
                "제품 확정 실패",
                isPresented: viewstore.binding(get: \.isShowingAlert, send: .dismissAlert),
                actions: { Button("확인", role: .cancel) { viewstore.send(.cancelAlert)} },
                message: { Text("예약을 확정할 수 없어요! \n 개수를 확인해주세요") }
            )
            .alert(
                "예약 취소하기",
                isPresented: viewstore.binding(get: \.isCancelAlertOn, send: .dismissCancelAlert),
                actions: {
                    Button("아니오", role: .cancel) { viewstore.send(.tabCancelAlertNO) }
                    Button("네", role: .destructive) { viewstore.send(.tabCancelAlertOK) }
                },
                message: { Text("예약을 취소하시겠습니까? \n 취소한 예약은 돌릴 수 없어요.") }
            )
            .alert(
                "예약 확정하기",
                isPresented: viewstore.binding(get: \.isConfirmAlertOn, send: .dismissConfirmAlert),
                actions: {
                    Button("아니오", role: .cancel) { viewstore.send(.tabConfirmAlertNO) }
                    Button("네", role: .destructive) { viewstore.send(.tabConfirmAlertOK) }
                },
                message: { Text("예약을 확정하시겠습니까?") }
            )
        }
    }
}
