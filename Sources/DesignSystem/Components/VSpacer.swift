//
//  VSpacer.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct VSpacer: View {
    var height: CGFloat
    var body: some View {
        Spacer()
            .frame(height: height)
    }
}
