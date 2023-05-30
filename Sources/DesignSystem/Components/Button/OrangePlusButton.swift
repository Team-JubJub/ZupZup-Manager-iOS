//
//  OrangePlusButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/02.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct OrangePlusButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(assetName: .ic_plus_orange)
                .resizable()
                .frame(
                    width: 24,
                    height: 24
                )
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: Device.Width * 28 / 390
                    )
                )
        }
    }
}
