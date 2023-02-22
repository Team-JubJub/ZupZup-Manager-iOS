//
//  OrderItem.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct OrderItem: View {
    
    let itemName: String
    let price: String
    @State var count: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(
                    width: Device.Width * 358 / 390,
                    height: 73
                )
                .cornerRadius(Device.cornerRadious)
                .foregroundColor(.designSystem(.zupzupWarmGray1))
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(itemName)
                        .font(SystemFont(size: ._17, weight: .semibold))
                        .foregroundColor(.designSystem(.Secondary))
                    Text(price)
                        .font(SystemFont(size: ._13, weight: .semibold))
                        .foregroundColor(.designSystem(.zupzupMain))
                }
                Spacer()
                HStack(spacing: 0) {
                    Button {
                        count -= 1
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.designSystem(.zupzupWarmGray4))
                                .overlay {
                                    Image(assetName: .ic_minus)
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                }
                        }
                        .frame(width: 20, height: 40)
                    }
                    
                    Spacer()
                    
                    Text("\(count)")
                        .font(SystemFont(size: ._17, weight: .regular))
                        .foregroundColor(.designSystem(.Secondary))
                    
                    Spacer()
                    
                    Button {
                        count += 1
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.designSystem(.zupzupWarmGray4))
                                .overlay {
                                    Image(assetName: .ic_plus)
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                }
                        }
                        .frame(width: 20, height: 40)
                    }
                }
                .frame(
                    width: Device.Width * 88 / 390,
                    height: 40
                )
            }
            .frame(
                width: Device.Width * 326 / 390,
                height: 43
            )
        }
    }
}
