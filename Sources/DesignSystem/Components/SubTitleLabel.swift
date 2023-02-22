//
//  ZupzupSubTitleLabel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/22.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct SubTitleLabel: View {
    
    let subtitle: String
    
    var body: some View {
        Text(subtitle)
            .font(SystemFont(size: ._20, weight: .semibold))
            .foregroundColor(.designSystem(.Secondary))
    }
}
