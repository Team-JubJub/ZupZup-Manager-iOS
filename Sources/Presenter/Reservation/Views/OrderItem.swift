//
//  OrderItem.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct OrderItem: View {
    
    var itemName: String
    var price: Int
    var count: Int
    var state: ReservationCondition
    
    let minusAction: () -> Void
    let plusAction: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: Device.Width * 358 / 390, height: 73)
                .foregroundColor(.designSystem(.pureWhite))
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    SuiteLabel(text: itemName, typo: .headline)
                    SuitLabel(text: price.toPrice(), typo: .subhead, color: .designSystem(.Tangerine300))
                }
                Spacer()
                    HStack(spacing: 0) {
                        if state == .new {
                            Button {
                                minusAction()
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.designSystem(.ivoryGray300))
                                        .overlay {
                                            Image(assetName: .ic_minus)
                                                .resizable()
                                                .frame(width: 12, height: 12)
                                        }
                                }
                                .frame(width: 20, height: 40)
                            }
                        }
                        
                        Spacer()
                        
                        SuitLabel(text: state == .new ? "\(count)" : "\(count)개", typo: .body)
                        
                        Spacer()
                        
                        if state == .new {
                            Button {
                                plusAction()
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.designSystem(.ivoryGray300))
                                        .overlay {
                                            Image(assetName: .ic_plus)
                                                .resizable()
                                                .frame(width: 12, height: 12)
                                        }
                                }
                                .frame(width: 20, height: 40)
                            }
                        }
                    }
                .frame(
                    width: Device.Width * 92 / 390,
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
