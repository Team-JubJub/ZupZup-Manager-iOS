//
//  RightChevronButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/04.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct RightChevronButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(assetName: .ic_direction)
                .resizable()
                .frame(width: 24, height: 24, alignment: .center)
        }
    }
}
