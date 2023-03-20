//
//  ConfirmBottomSheet.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ConfirmBottomSheet: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("해당 주문을 확정할까요?")
                    .font(SystemFont(size: ._20, weight: .semibold))
                    .foregroundColor(.designSystem(.Secondary))
                Spacer()
            }
            .padding(EdgeInsets(top: Device.VPadding, leading: Device.HPadding, bottom: Device.VPadding / 2, trailing: 0))
            
            HStack(spacing: 0) {
                Text("아래 주문을 확인해주세요")
                    .font(SystemFont(size: ._12, weight: .regular))
                    .foregroundColor(.designSystem(.Secondary))
                Spacer()
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
                                RectangleWithIcon(assetName: .clock)
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.HPadding / 2))
                            .frame(height: Device.Height * 65 / 844)
                            
                            VStack(alignment: .leading, spacing: 0) {
                    
                                Text("주문자")
                                    .foregroundColor(.designSystem(.zupzupMain))
                                    .font(SystemFont(size: ._12, weight: .semibold))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding * 5 / 16, trailing: 0))
                                
                                Text("닉네임")
                                    .foregroundColor(.designSystem(.Secondary))
                                    .font(SystemFont(size: ._17, weight: .regular))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding * 5 / 16, trailing: 0))
                                
                                Text("010-4602-1620")
                                    .foregroundColor(.designSystem(.zupzupWarmGray6))
                                    .font(SystemFont(size: ._13, weight: .regular))
                                Spacer()
                            }
                            .frame(height: Device.Height * 65 / 844)
                        }
                        
                        Spacer()
                                                
                        VStack(spacing: 0) {
                            RectangleWithIcon(assetName: .clock)
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.HPadding / 2))
                        .frame(height: Device.Height * 65 / 844)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("방문예정시간")
                                .foregroundColor(.designSystem(.zupzupMain))
                                .font(SystemFont(size: ._12, weight: .semibold))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding * 5 / 16, trailing: 0))
                            
                            Text("19:00 ~ 19:20")
                                .foregroundColor(.designSystem(.Secondary))
                                .font(SystemFont(size: ._17, weight: .regular))
                            Spacer()
                        }
                        .frame(height: Device.Height * 65 / 844)
                    }
                    .frame(width: Device.Width * 326 / 390, height: Device.Height * 65 / 844)
                }
            
            VSpacer(height: Device.VPadding)
            
            ZStack(alignment: .center) {
                Rectangle()
                    .foregroundColor(.designSystem(.SecondaryText))
                    .frame(width: Device.Width * 358 / 390, height: Device.Height * 145 / 844)
                    .cornerRadius(16)
                
                VStack {
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Text("총 합계")
                            .font(SystemFont(size: ._15, weight: .regular))
                            .foregroundColor(.designSystem(.Secondary))
                        Spacer()
                        Text("1,000,000원")
                            .font(SystemFont(size: ._20, weight: .semibold))
                            .foregroundColor(.designSystem(.zupzupMain))
                    }
                    Spacer()
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.designSystem(.zupzupWarmGray3))
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Spacer()
                        Text("초코 크로와상")
                            .foregroundColor(.designSystem(.Secondary))
                            .font(SystemFont(size: ._15, weight: .regular))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.VPadding))
                        
                        Text("6,000원")
                            .foregroundColor(.designSystem(.zupzupWarmGray6))
                            .font(SystemFont(size: ._15, weight: .regular))
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Spacer()
                        Text("소금빵")
                            .foregroundColor(.designSystem(.Secondary))
                            .font(SystemFont(size: ._15, weight: .regular))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                        
                        Text("1,400원")
                            .foregroundColor(.designSystem(.zupzupWarmGray6))
                            .font(SystemFont(size: ._15, weight: .regular))
                    }
                    Spacer()
                }
                .frame(width: Device.Width * 326 / 390, height: Device.Height * 112 / 844)
            }
            
            VSpacer(height: Device.VPadding)
                
            HStack(spacing: 0) {
                Button {
                    // TODO: 반려 액션 추가
                    print("반려 버튼을 탭하셨습니다.")
                } label: {
                    Rectangle()
                        .foregroundColor(.designSystem(.zupzupWarmGray3))
                        .cornerRadius(16)
                        .overlay {
                            Text("반려")
                                .foregroundColor(.designSystem(.zupzupWarmGray6))
                                .font(SystemFont(size: ._17, weight: .regular))
                        }
                        .padding(EdgeInsets(top: 0, leading: Device.HPadding, bottom: 0, trailing: 0))
                }
                
                HSpacer(width: Device.HPadding)
                
                Button {
                    // TODO: 확정 액션 추가
                    print("확정 버튼을 탭하셨습니다.")
                } label: {
                    Rectangle()
                        .foregroundColor(.designSystem(.confirmColor))
                        .cornerRadius(16)
                        .overlay {
                            Text("확정")
                                .foregroundColor(.designSystem(.OffWhite))
                                .font(SystemFont(size: ._17, weight: .regular))
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.HPadding))
                }
            }
        }
    }
}
