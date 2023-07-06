//
//  TabbarItem.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct TabbarItem: View {
    
    let defaultAsset: AssetName
    let selectedAsset: AssetName
    @Binding var selectedIndex: Int
    let num: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 3)
                .foregroundColor(selectedIndex == num ? Color.designSystem(.Tangerine300) : Color.designSystem(.neutralGray300))
            Spacer()
            Image(assetName: selectedIndex == num ? selectedAsset : defaultAsset)
                .resizable()
                .frame(width: 24, height: 24)
                .font(.system(size: 24, weight: .light))
                .foregroundColor(selectedIndex == num ? Color.designSystem(.Tangerine300) : Color.designSystem(.neutralGray300))
            Spacer()
        }
        .frame(height: 50)
        .gesture(
            TapGesture()
                .onEnded { _ in
                    withAnimation {
                        selectedIndex = num
                    }
                }
        )
    }
}
