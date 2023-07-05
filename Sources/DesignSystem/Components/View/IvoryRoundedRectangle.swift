//
//  RoundedRectangle.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/04.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct IvoryRoundedRectangle: View {
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(Color.designSystem(.ivoryGray200)!, lineWidth: 1)
            .background(Color.designSystem(.ivoryGray100))
            .frame(
                width: width,
                height: height
            )
    }
}
