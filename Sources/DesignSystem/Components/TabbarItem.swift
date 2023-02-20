//
//  TabbarItem.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct TabbarItem: View {
    
    let symbolName: String
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(
                    width: Device.Width / 2,
                    height: 5
                )
                .foregroundColor(.pink)
                .background(Color.pink)
            Image(systemName: symbolName)
        }
    }
}
