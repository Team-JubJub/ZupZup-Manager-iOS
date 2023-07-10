//
//  MinusButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct MinusButton: View {
    
    let palette: Palette
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 0) {
                Circle()
                    .foregroundColor(.designSystem(palette))
                    .frame(width: 20, height: 20)
                    .overlay {
                        Image(assetName: .ic_minus)
                            .resizable()
                            .frame(width: 12, height: 12)
                    }
                Spacer()
            }
            .frame(width: 40, height: 20)
        }
    }
}
