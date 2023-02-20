//
//  Hspacer.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct HSpacer: View {
    var width: CGFloat
    var body: some View {
        Spacer()
            .frame(width: width)
    }
}
