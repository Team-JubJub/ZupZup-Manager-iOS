//
//  LargeTitleLabel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/02.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct LargeNavigationTitle: View {
    
    let title: String
    
    var body: some View {
        HStack(spacing: 0) {
            SuiteLabel(text: title, typo: .hero)
            InfiniteSpacer()
        }
    }
}
