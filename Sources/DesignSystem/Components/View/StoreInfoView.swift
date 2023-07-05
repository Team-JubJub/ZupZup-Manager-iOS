//
//  StoreInfoView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/02.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct StoreInfoView: View {
    
    let store: String
    let event: String
    let time: String
    
    var body: some View {
        VStack(spacing: 1) {
            ZStack(alignment: .center) {
                Rectangle()
                    .foregroundColor(.designSystem(.zupzupWarmGray1))
                    .frame(
                        width: Device.Width * 358 / 390,
                        height: 97
                    )
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        RectangleWithIcon(assetName: .ic_home, color: .designSystem(.zupzupWarmGray5)!)
                        Spacer()
                    }
                    HSpacer(width: Device.HPadding / 2)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("우리 가게")
                            .foregroundColor(.designSystem(.zupzupMain))
                            .font((SystemFont(size: ._12, weight: .semibold)))
                            .padding(
                                EdgeInsets(
                                    top: 0,
                                    leading: 0,
                                    bottom: 5,
                                    trailing: 0
                                )
                            )
                        
                        Text(store)
                            .font(SystemFont(size: ._17, weight: .regular))
                            .foregroundColor(.designSystem(.Secondary))
                            .padding(
                                EdgeInsets(
                                    top: 0,
                                    leading: 0,
                                    bottom: 5,
                                    trailing: 0
                                )
                            )
                        
                        Text(time)
                            .font(SystemFont(size: ._13, weight: .regular))
                            .foregroundColor(.designSystem(.zupzupWarmGray6))
                        Spacer()
                    }
                    .frame(height: 65)
                    Spacer()
                }
                .frame(
                    width: Device.Width * 326 / 390,
                    height: 65
                )
            }
            
            ZStack(alignment: .center) {
                Rectangle()
                    .foregroundColor(.designSystem(.zupzupWarmGray1))
                    .frame(
                        width: Device.Width * 358 / 390,
                        height: 73
                    )
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        RectangleWithIcon(assetName: .ic_gift, color: .designSystem(.zupzupWarmGray5)!)
                        Spacer()
                    }
                    
                    HSpacer(width: Device.HPadding / 2)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("이벤트")
                            .foregroundColor(.designSystem(.zupzupMain))
                            .font((SystemFont(size: ._12, weight: .semibold)))
                            .padding(
                                EdgeInsets(
                                    top: 0,
                                    leading: 0,
                                    bottom: 5,
                                    trailing: 0
                                )
                            )
                        
                        Text(event)
                            .font(SystemFont(size: ._15, weight: .regular))
                            .foregroundColor(.designSystem(.Secondary))
                        
                        Spacer()
                    }
                    .frame(height: 41)
                
                    Spacer()
                }
                .frame(
                    width: Device.Width * 326 / 390,
                    height: 41
                )
            }
            
            ZStack(alignment: .center) {
                Rectangle()
                    .foregroundColor(.designSystem(.zupzupWarmGray1))
                    .frame(
                        width: Device.Width * 358 / 390,
                        height: 73
                    )
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        RectangleWithIcon(assetName: .ic_clock, color: .designSystem(.zupzupWarmGray5)!)
                        Spacer()
                    }
                    
                    HSpacer(width: Device.HPadding / 2)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("오늘 할인 시간")
                            .foregroundColor(.designSystem(.zupzupMain))
                            .font((SystemFont(size: ._12, weight: .semibold)))
                            .padding(
                                EdgeInsets(
                                    top: 0,
                                    leading: 0,
                                    bottom: 5,
                                    trailing: 0
                                )
                            )
                        
                        Text("19:00 ~ 19:20")
                            .font(SystemFont(size: ._17, weight: .regular))
                            .foregroundColor(.designSystem(.Secondary))
                        
                        Spacer()
                    }
                    .frame(height: 41)
                
                    Spacer()
                }
                .frame(
                    width: Device.Width * 326 / 390,
                    height: 41
                )
            }
        }
        .cornerRadius(14)
        .padding(
            EdgeInsets(
                top: Device.Height * 26 / 844,
                leading: 0,
                bottom: 0,
                trailing: 0
            )
        )
    }
}
