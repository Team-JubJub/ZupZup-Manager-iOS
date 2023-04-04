//
//  NavigationBarWithDismiss.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/04.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct NavigationBarWithDismiss: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let label: String
    
    var body: some View {
        HStack(spacing: 5) {
            HSpacer(width: 4)
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 11, height: 19)
                    .foregroundColor(.designSystem(.zupzupMain))
                    .aspectRatio(contentMode: .fit)
                
                Text(label)
                    .font(SystemFont(size: ._17, weight: .regular))
                    .foregroundColor(.designSystem(.zupzupMain))
            }
            Spacer()
        }
        .frame(height: 42)
    }
}
