//
//  ContentView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/18.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedIndex = 0
    let tabBarImangeNames = ["shippingbox", "gearshape"]
    let tabBarNames = ["Menu", "Order"]
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    switch selectedIndex {
                    case 0:
                        ReservationView()
                    default:
                        SettingView()
                    }
                }
                Spacer()
                HStack(spacing: 0) {
                    ForEach(tabBarImangeNames.indices, id: \.self) { num in
                        TabbarItem(symbolName: tabBarImangeNames[num], selectedIndex: $selectedIndex, num: num)
                    }
                }
            }
        }
    }
}
