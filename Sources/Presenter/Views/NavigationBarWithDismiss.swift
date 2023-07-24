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
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.designSystem(.Tangerine300))
                    .aspectRatio(contentMode: .fit)
                
                SuitLabel(text: label, typo: .body, color: .designSystem(.Tangerine300))
                    .lineLimit(1)
            }
            Spacer()
        }
        .frame(height: 42)
    }
}
