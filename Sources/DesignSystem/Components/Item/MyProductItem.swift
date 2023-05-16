//
//  MyProductItem.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/02.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Kingfisher

struct MyProductItem: View {
    
    @Binding var isEditable: Bool
    @State var count: Int
    
    let url: String
    let title: String
    let originalPrice: Int
    let salePrice: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.designSystem(.zupzupWarmGray1))
                .frame(width: Device.Width * 358 / 390, height: 73)
            
            HStack(spacing: 0) {
                KFImage(URL(string: url))
                    .resizable()
                    .frame(width: Device.Width * 84 / 390, height: 73)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .foregroundColor(.designSystem(.Secondary))
                        .font(SystemFont(size: ._17, weight: .semibold))
                    
                    HStack(spacing: 0) {
                        Text("\(salePrice)원")
                            .font(SystemFont(size: ._13, weight: .semibold))
                            .foregroundColor(.designSystem(.zupzupMain))
                            .padding(
                                EdgeInsets(
                                    top: 0,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: Device.HPadding / 2
                                )
                            )
                        
                        ZStack {
                            Text("\(originalPrice)원")
                                .font(SystemFont(size: ._13, weight: .semibold))
                                .foregroundColor(.designSystem(.zupzupWarmGray5))
                            
                            Rectangle()
                                .frame(width: 40, height: 1)
                                .foregroundColor(.designSystem(.zupzupWarmGray5))
                        }
                    }
                }
                .padding(8)
                
                Spacer()
                
                if isEditable {
                    Button {
                        print("minus Button tapped")
                        self.count -= 1
                    } label: {
                        Circle()
                            .foregroundColor(.designSystem(.zupzupWarmGray4))
                            .overlay {
                                Image(assetName: .ic_minus)
                                    .resizable()
                                    .frame(width: 12, height: 12)
                            }
                            .frame(width: 20, height: 20)
                            .padding(
                                EdgeInsets(
                                    top: 10,
                                    leading: 10,
                                    bottom: 10,
                                    trailing: Device.Width * 23 / 390
                                )
                            )
                    }
                }
                
                Text("\(count)")
                    .font(SystemFont(size: ._17, weight: .regular))
                    .foregroundColor(.designSystem(.zupzupMain))
                
                if !isEditable {
                    Text("EA")
                        .font(SystemFont(size: ._17, weight: .regular))
                        .foregroundColor(.designSystem(.zupzupWarmGray5))
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: Device.HPadding / 4,
                                bottom: 0,
                                trailing: Device.Width * 42.5 / 390
                            )
                        )
                } else {
                    Button {
                        print("plus Button tapped")
                        self.count += 1
                    } label: {
                        Circle()
                            .foregroundColor(.designSystem(.zupzupWarmGray4))
                            .overlay {
                                Image(assetName: .ic_plus)
                                    .resizable()
                                    .frame(width: 12, height: 12)
                            }
                            .frame(
                                width: 20,
                                height: 20
                            )
                            .padding(
                                EdgeInsets(
                                    top: 10,
                                    leading: Device.Width * 23 / 390,
                                    bottom: 10,
                                    trailing: Device.HPadding
                                )
                            )
                    }
                }
            }
            .frame(
                width: Device.Width * 358 / 390
            )
        }
        .cornerRadius(Device.cornerRadious)
    }
}
