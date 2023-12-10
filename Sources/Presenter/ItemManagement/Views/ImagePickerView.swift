//
//  ImagePickerView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/11.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ImagePickerView: View {
    
    @Binding var image: UIImage?
    
    var imageUrl: String?
    let action: () -> Void
    
    var body: some View {
        ZStack {
            KFImage(URL(string: imageUrl ?? ""))
                .resizable()
                .placeholder {
                    Image(assetName: .ic_mockImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                }
                .scaledToFill()
                .frame(height: 250)
                .clipped()
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
            }
            
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
