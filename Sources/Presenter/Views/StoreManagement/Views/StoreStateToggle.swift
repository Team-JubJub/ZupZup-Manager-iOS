//
//  StoreStateToggle.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/04.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct StoreStateToggle: ToggleStyle {
    
    let action: () -> Void
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 24)
            .stroke(configuration.isOn ? Color.clear : Color.designSystem(.ivoryGray400)!, lineWidth: 4)
            .background(configuration.isOn ? Color.designSystem(.Tangerine300) : Color.designSystem(.ivoryGray200))
            .overlay(
                GeometryReader(content: { geometry in
                    
                    let toggleHeight = geometry.size.height
                    let circleHeight = configuration.isOn ? geometry.size.height * 3 / 4 : geometry.size.height / 2
                    
                    let leftPosition = (toggleHeight - circleHeight) / 2
                    let rightPosition = circleHeight
                    
                    ZStack {
                        Circle()
                            .foregroundColor(configuration.isOn ? .designSystem(.ivoryGray100) : .designSystem(.ivoryGray400))
                            .frame(width: circleHeight)
                    }
                    .offset(
                        x: configuration.isOn ? rightPosition : leftPosition,
                        y: (toggleHeight - circleHeight) / 2
                    )
                })
            )
            .onTapGesture {
                withAnimation { configuration.isOn.toggle() }
                action()
            }
    }
}
