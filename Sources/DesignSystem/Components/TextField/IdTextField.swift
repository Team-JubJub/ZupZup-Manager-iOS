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
            Rectangle()
                .cornerRadius(14)
                .foregroundColor(.designSystem(.zupzupWarmGray1))
                .frame(height: 56)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 24,
                        bottom: 0,
                        trailing: 24
                    )
                )
            HStack {
                TextField("아이디", text: $idString)
                Image(assetName: .xCircle)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        idString = ""
                    }
            }
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 42,
                    bottom: 0,
                    trailing: 36
                )
            )
        }
    }
}
