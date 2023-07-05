//
//  RectangleWithIcon.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/02.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct RectangleWithIcon: View {
    
    let assetName: AssetName
    let color: Color
    
    var body: some View {
        Rectangle()
            .frame(width: 30, height: 30)
            .cornerRadius(8)
            .foregroundColor(color)
            .overlay {
                Image(assetName: assetName)
                    .resizable()
                    .frame(width: 22, height: 22)
            }
    }
}
