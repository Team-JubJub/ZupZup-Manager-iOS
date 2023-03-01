//
//  BoxImage.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/01.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct BoxImage: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
            Image(assetName: .box)
                .resizable()
                .frame(width: 96, height: 113)
                .scaledToFit()
        }
    }
}
