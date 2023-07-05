//
//  SwiftUIView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/01.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct IdTextField: View {
    
    @Binding var idString: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.designSystem(.ivoryGray500)!, lineWidth: 1)
                .foregroundColor(.designSystem(.pureWhite))
                .frame(height: 56)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 16,
                        bottom: 0,
                        trailing: 16
                    )
                )
            TextField(
                "아이디",
                text: $idString,
                prompt: Text("아이디").foregroundColor(.designSystem(.ivoryGray500))
            )
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 32,
                    bottom: 0,
                    trailing: 32
                )
            )
        }
    }
}
