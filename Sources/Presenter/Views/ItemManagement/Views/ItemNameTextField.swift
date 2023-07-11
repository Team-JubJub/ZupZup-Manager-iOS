//
//  ItemNameTextField.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/11.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ItemNameTextField: View {
    
    @Binding var name: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TextField("제품명을 입력해주세요", text: $name)
                    .font(Suit(weight: .regular, size: ._17))
                
                Spacer()
                
                Button {
                    action()
                } label: {
                    ZStack {
                        Image(assetName: .ic_cancel)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 44, height: 44)
                }
            }
            
            Rectangle()
                .frame(width: Device.WidthWithPadding, height: 1)
        }
    }
}
