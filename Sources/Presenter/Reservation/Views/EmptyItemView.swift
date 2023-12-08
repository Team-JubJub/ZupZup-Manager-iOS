//
//  EmptyItemView.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct EmptyItemView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: Device.Width * 0.7, height: Device.Width * 0.7)
                .foregroundStyle(Color.designSystem(.orange200)!)
            
            Circle()
                .frame(width: Device.Width * 0.68, height: Device.Width * 0.68)
                .foregroundStyle(Color.designSystem(.Tangerine100)!)
                .contentTransition(.opacity)
        
            VStack(spacing: 12) {
                Image(assetName: .ic_empty_item)
                    .resizable()
                    .frame(width: Device.Width * 0.4, height: Device.Width * 0.6)
                    .scaledToFit()
                
                SuiteLabel(
                    text: "아직 등록된 제품이 없어요!\n우측 상단의 버튼을 눌러보세요.",
                    typo: .headline,
                    color: .designSystem(.Tangerine600)
                )
            }
        }
    }
}

//#Preview {
//    EmptyItemView()
//}
