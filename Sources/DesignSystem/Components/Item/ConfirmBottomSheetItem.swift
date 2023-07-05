//
//  ConfirmBottomSheetItem.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/01.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ConfirmBottomSheetItem: View {
    
    let itemName: String
    let price: Int
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Text(itemName)
                .foregroundColor(.designSystem(.pureBlack))
                .font(SystemFont(size: ._15, weight: .regular))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Device.VPadding))

            Text("\(price)원")
                .foregroundColor(.designSystem(.pureWhite))
                .font(SystemFont(size: ._15, weight: .regular))
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
    }
}
