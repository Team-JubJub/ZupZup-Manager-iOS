//
//  StoreManageViewItem.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/04.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct StoreManageViewItem: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            SystemLabel(text: title, typo: .callout)
            InfiniteSpacer()
            RightChevronButton { action() }
        }
        .frame(width: Device.Width * 350 / 390, height: 60)
        
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.designSystem(.ivoryGray200))
    }
}
