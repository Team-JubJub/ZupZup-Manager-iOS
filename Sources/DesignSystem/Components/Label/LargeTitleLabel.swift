//
//  LargeTitleLabel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/02.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct LargeTitleLabel: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(.designSystem(.Secondary))
            .font(SystemFont(size: ._34, weight: .semibold))
    }
}
