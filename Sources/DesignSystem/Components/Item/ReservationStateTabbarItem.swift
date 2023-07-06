//
//  ReservationStateTabbarItem.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ReservationStateTabbarItem: View {
    
    @Binding var selectedIndex: Int
    
    let num: Int
    let name: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            SuiteLabel(
                text: name,
                typo: .headline,
                color: selectedIndex == num ? Color.designSystem(.yellow800) : Color.designSystem(.ivoryGray300)
            )
            Spacer()
            Rectangle()
                .frame(height: 2)
                .foregroundColor(selectedIndex == num ? Color.designSystem(.yellow800) : Color.designSystem(.ivoryGray300))
        }
        .frame(height: Device.Height * 44 / 844)
        .gesture(
            TapGesture()
                .onEnded { _ in
                    action()
                    withAnimation {
                        selectedIndex = num
                    }
                }
        )
    }
}
