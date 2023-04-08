//
//  TrashTongButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct TrashTongButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(assetName: .ic_trashTong)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}
