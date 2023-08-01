//
//  BoxImageHighlighted.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/06/01.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ZupZupBox: View {
    var body: some View {
        Image(assetName: .ic_zupzup_box)
            .resizable()
            .frame(width: 108, height: 135)
            .scaledToFit()
    }
}
