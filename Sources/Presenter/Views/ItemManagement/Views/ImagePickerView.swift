//
//  ImagePickerView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/11.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ImagePickerView: View {
    
    @Binding var image: UIImage?
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Image(uiImage: ((image ?? UIImage(named: "ic_mockImage"))!))
                .resizable()
                .scaledToFill()
                .frame(height: 192)
                .clipped()
            
            Rectangle()
                .foregroundColor(.designSystem(.ScrimBlack40))
            
            ZStack {
                Image(assetName: .ic_edit_white)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .scaledToFit()
            }
            .frame(width: Device.WidthWithPadding / 2, height: 86)
            .onTapGesture { action() }
        }
    }
}
