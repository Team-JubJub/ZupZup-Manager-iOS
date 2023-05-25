//
//  EditButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/02.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct EditButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("수정하기")
                .foregroundColor(.designSystem(.zupzupMain))
                .font(SystemFont(size: ._20, weight: .semibold))
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: Device.Width * 17 / 390
                    )
                )
        }
    }
}
