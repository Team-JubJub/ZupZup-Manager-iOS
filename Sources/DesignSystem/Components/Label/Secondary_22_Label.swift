//
//  Secondary22Label.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/02.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct Secondary_22_Label: View {
    
    let title: String
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .foregroundColor(.designSystem(.Secondary))
                .font(SystemFont(size: ._22, weight: .semibold))
            Spacer()
        }
        .padding(
            EdgeInsets(
                top: 0,
                leading: Device.HPadding,
                bottom: 0,
                trailing: Device.HPadding
            )
        )
    }
}

struct Secondary22Label_Previews: PreviewProvider {
    static var previews: some View {
        Secondary_22_Label()
    }
}
