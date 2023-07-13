//
//  ConfirmBottomSheet.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ConfirmBottomSheet: View {
    
    @StateObject var store: ReservationDetailStore
    
    var body: some View {
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
                                
                                SuitLabel(text: store.reservation.customerName, typo: .body)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding * 5 / 16, trailing: 0))
                                
                                SuitLabel(text: store.reservation.phoneNumber, typo: .subhead, color: .designSystem(.ivoryGray300))
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
                            
                            SuitLabel(text: ReservationHelper.twentyMinutePlus(reservation: store.reservation), typo: .body)
                            
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
                        
                        SuiteLabel(text: ReservationHelper.makeTotalPrice(reservation: store.reservation).toPrice(), typo: .h3, color: .designSystem(.Tangerine300))
                    }
                    
                    InfiniteSpacer()
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.designSystem(.ivoryGray150))
                    
                    InfiniteSpacer()
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(store.reservation.cartList, id: \.self) { item in
                                ConfirmBottomSheetItem(itemName: item.name, price: item.salesPrice)
                            }
                        }
                    }
                }
                .frame(width: Device.Width * 326 / 390, height: Device.Height * 112 / 844)
            }
            
            VSpacer(height: Device.VPadding)
            
            HStack(spacing: 0) {
                Button {
                    store.reduce(action: .tabCancelButton)
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
                    store.reduce(action: .tabComfirmButton)
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
    }
}
