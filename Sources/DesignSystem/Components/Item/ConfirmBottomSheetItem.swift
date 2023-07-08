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
            SuitLabel(text: itemName, typo: .subhead)
            HSpacer(width: 8)
            SuitLabel(text: price.toPrice(), typo: .subhead, color: .designSystem(.ivoryGray300))
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
    }
}
