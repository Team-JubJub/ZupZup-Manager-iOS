//
//  LoginView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/27.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var idString: String = "아이디"
    @State var password: String = "비밀번호"
    
    var body: some View {
        VStack {
            
            Spacer()
            
            ZStack {
                Circle()
                    .frame(width: 200, height: 200)
                Image(assetName: .box)
                    .resizable()
                    .frame(width: 96, height: 113)
                    .scaledToFit()
            }
            
            Spacer()
            TextField(text: $idString, prompt: "아") {
                Rectangle()                    
            }
            
            Button {
                print("button tabbed")
            } label: {
                ZStack {
                    Rectangle()
                        .cornerRadius(14)
                        .foregroundColor(.designSystem(.zupzupMain))
                        .frame(height: Device.Height * 57 / 844)
                        .padding(EdgeInsets(top: 0, leading: Device.horizontalPadding, bottom: 0, trailing: Device.horizontalPadding))
                    Text("로그인")
                        .font(SystemFont(size: ._17, weight: .bold))
                        .foregroundColor(.designSystem(.Secondary))
                }
            }

        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
