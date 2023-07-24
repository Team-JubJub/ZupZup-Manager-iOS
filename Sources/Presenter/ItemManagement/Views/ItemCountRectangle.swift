//
//  RectangleWithTwoButton.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ItemCountRectangle: View {
    
    @Binding var count: Int
    
    let minusButtonAction: () -> Void
    let plusButtonAction: () -> Void
    
    var body: some View {
        
        VStack(spacing: 0) {
            IvoryRoundedRectangle(width: Device.WidthWithPadding, height: 137)
                .overlay {
                    VStack(spacing: 20.5) {
                        ZStack {
                            TextField("0", value: $count, formatter: currencyFormatter)
                                .font(Suite(weight: .heavy, size: ._34))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.designSystem(.pureBlack))
                                .keyboardType(.numberPad)
                        }
                        
                        Rectangle()
                            .frame(width: Device.WidthWithPadding, height: 1)
                            .foregroundColor(.designSystem(.ivoryGray100))
                        
                        HStack(spacing: 0) {
                            InfiniteSpacer()
                            
                            MinusButton(palette: .ivoryGray300, size: 28) { minusButtonAction() }
                            
                            SuiteLabel(text: count.toString(), typo: .h3)
                                .frame(width: 100, height: 28)
                            
                            PlusButton(palette: .ivoryGray300, size: 28) { plusButtonAction() }
                            
                            InfiniteSpacer()
                        }
                    }
                }
        }
    }
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}
