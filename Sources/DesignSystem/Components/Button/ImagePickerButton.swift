//
//  ImagePickerButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ImagePickerButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Circle()
                .foregroundColor(.designSystem(.zupzupMain))
                .frame(width: 56, height: 56)
                .overlay {
                    Image(assetName: .ic_edit)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
        }
    }
}
