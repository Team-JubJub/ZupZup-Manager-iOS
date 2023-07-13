//
//  ReserveInfoView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ReserveInfoView: View {
    
    let customer: String
    let phoneNumber: String
    let arrivedTime: String
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.designSystem(.ivoryGray150))
                        .frame(height: 97)
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            RectangleWithIcon(assetName: .ic_user, color: .designSystem(.ivoryGray300)!)
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                        
                        VStack(alignment: .leading, spacing: 0) {
                            SuitLabel(text: "주문자", typo: .footnote, color: .designSystem(.Tangerine300))
                                .padding(EdgeInsets(top: 3, leading: 0, bottom: 5, trailing: 0))
                            SuitLabel(text: customer, typo: .body)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            SuitLabel(text: phoneNumber, typo: .footnote, color: .designSystem(.ivoryGray300))
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
                ZStack {
                    Rectangle()
                        .foregroundColor(.designSystem(.ivoryGray150))
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            RectangleWithIcon(assetName: .ic_clock_white, color: .designSystem(.ivoryGray300)!)
                            Spacer()
                        }
                        .padding(
                            EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
                        )
                        VStack(alignment: .leading, spacing: 0) {
                            SuitLabel(text: "방문 예정 시간", typo: .caption, color: .designSystem(.Tangerine300))
                                .padding(EdgeInsets(top: 3, leading: 0, bottom: 5, trailing: 0))
                            SuitLabel(text: arrivedTime, typo: .body)
                            Spacer()
                        }
                        .frame(height: 42)
                        Spacer()
                    }
                    .frame(
                        width: Device.Width * 326 / 390,
                        height: 42
                    )
                }
            }
            .frame(
                width: Device.Width * 358 / 390,
                height: 172
            )
            .cornerRadius(Device.cornerRadious)
        }
    }
}
