//
//  HalfSquareButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/05.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct HalfSquareButton: View {
    let backgroundColor: Palette
    let fontColor: Palette
    let title: String
    
    var body: some View {
        Rectangle()
            .foregroundColor(.designSystem(backgroundColor))
            .cornerRadius(16)
            .overlay {
                SuiteLabel(text: title, typo: .headline)
                Text(title)
                    .foregroundColor(.designSystem(fontColor))
                    .font(SystemFont(size: ._17, weight: .regular))
            }
    }
}
