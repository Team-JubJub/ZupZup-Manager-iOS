//
//  MyProductItem.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/02.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ProductGridItem: View {
    
    @Binding var isEditable: Bool
    @Binding var count: Int
    @Binding var url: String
    @Binding var title: String
    @Binding var originalPrice: Int
    @Binding var salePrice: Int
    
    let minusAction: () -> Void
    let plusAction: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.designSystem(count == 0 ? .ivoryGray300 : .ivoryGray200)!, lineWidth: 2)
                    .overlay {
                        VStack(spacing: 0) {
                            ZStack {
                                KFImage(URL(string: url))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: Device.Width * 175 / 390, height: 110)
                                    .clipped()
                                if count == 0 {
                                    Rectangle()
                                        .frame(width: Device.Width * 175 / 390, height: 110)
                                        .foregroundColor(.designSystem(.ScrimBlack40))
                                }
                            }
                            
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    SuiteLabel(
                                        text: title,
                                        typo: .headline,
                                        color: .designSystem(count == 0 ? .ivoryGray500 : .pureBlack)
                                    )
                                    .lineLimit(2)
                                    InfiniteSpacer()
                                }
                                
                                InfiniteSpacer()
                                
                                HStack(spacing: 0) {
                                    SuiteLabel(
                                        text: "\(salePrice)원",
                                        typo: .headline,
                                        color: .designSystem(count == 0 ? .ivoryGray400 : .Tangerine300)
                                    )
                                    
                                    InfiniteSpacer()
                                    
                                    SuitLabel(
                                        text: count == 0 ? "품절" : count.toString() + "개",
                                        typo: .subhead,
                                        color: .designSystem(.ivoryGray400)
                                    )
                                }
                            }
                            .padding(Device.VPadding / 2)
                        }
                        
                    }
                    .frame(width: Device.Width * 175 / 390, height: 200)
                    .background(Color.designSystem(count == 0 ? .ivoryGray200 : .ivoryGray100))
            }
            .cornerRadius(8)
        }
    }
}
