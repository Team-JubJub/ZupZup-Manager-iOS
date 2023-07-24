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
    
    var count: Int
    var url: String
    var title: String
    var originalPrice: Int
    var salePrice: Int
    
    enum ItemType {
        case common
        case editCount
        case editInfo
    }
    
    let type: ItemType
    
    var minusAction: (() -> Void)?
    var plusAction: (() -> Void)?
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.designSystem(count == 0 && type == .common ? .ivoryGray300 : .ivoryGray200)!, lineWidth: 2)
                    .overlay {
                        VStack(spacing: 0) {
                            ZStack {
                                KFImage(URL(string: url))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: Device.Width * 175 / 390, height: 110)
                                    .clipped()
                                
                                if (count == 0 && type == .common) || type == .editInfo {
                                    Rectangle()
                                        .frame(width: Device.Width * 175 / 390, height: 110)
                                        .foregroundColor(.designSystem(.ScrimBlack40))
                                    
                                    if type == .editInfo {
                                        Image(assetName: .ic_edit_white)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                    }
                                }
                            }
                            
                            VStack(spacing: 0) {
                                HStack(alignment: .top, spacing: 0) {
                                    SuiteLabel(
                                        text: title,
                                        typo: .headline,
                                        color: .designSystem(count == 0 && type == .common ? .ivoryGray500 : .pureBlack)
                                    )
                                    .multilineTextAlignment(.leading)
                                    
                                    InfiniteSpacer()
                                }
                                
                                InfiniteSpacer()
                                
                                switch type {
                                case .common, .editInfo:
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
                                case .editCount:
                                    HStack {
                                        MinusButton(palette: .ivoryGray400, size: 20) { minusAction!() }
                                        InfiniteSpacer()
                                        SuitLabel(text: count.toString(), typo: .headline)
                                        InfiniteSpacer()
                                        PlusButton(palette: .ivoryGray400, size: 20) { plusAction!() }
                                    }
                                }
                            }
                            .padding(Device.VPadding / 2)
                        }
                    }
                    .frame(width: Device.Width * 175 / 390, height: 200)
                    .background(Color.designSystem(count == 0 && type == .common ? .ivoryGray200 : .ivoryGray100))
            }
            .cornerRadius(8)
        }
    }
}
