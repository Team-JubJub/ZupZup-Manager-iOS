//
//  ContentView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/18.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ReservationView()
                .tabItem {
                    Text("내 예약")
                }
            SettingView()
                .tabItem {
                    Text("설정")
                }
        }
    }
}
