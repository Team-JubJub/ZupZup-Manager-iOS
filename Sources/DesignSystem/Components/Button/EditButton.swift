//
//  EditButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct EditButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.clear)
                Image(assetName: .ic_edit)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .background(Color.red)
        }
    }
}
