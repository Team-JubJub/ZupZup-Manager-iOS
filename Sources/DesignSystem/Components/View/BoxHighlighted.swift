//
//  BoxImageHighlighted.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/06/01.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct BoxHighlighted: View {
    var body: some View {
        Image(assetName: .ic_boxHighlighted)
            .resizable()
            .frame(width: 122, height: 161)
            .scaledToFit()
    }
}
