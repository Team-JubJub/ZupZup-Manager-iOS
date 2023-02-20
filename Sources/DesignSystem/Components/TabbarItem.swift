//
//  TabbarItem.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct TabbarItem: View {
    
    let symbolName: String
    @Binding var selectedIndex: Int
    let num: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 4)
                .foregroundColor(selectedIndex == num ? Color.designSystem(.zupzupMain) : Color.designSystem(.zupzupWarmGray5))
            Spacer()
            Image(systemName: symbolName)
                .font(.system(size: 17, weight: .light))
                .foregroundColor(selectedIndex == num ? Color.designSystem(.zupzupMain) : Color.designSystem(.zupzupWarmGray5))
            Spacer()
        }
        .frame(height: Device.Height * 94 / 844)
        .gesture(
            TapGesture()
                .onEnded { _ in
                    selectedIndex = num
                }
        )
    }
}
