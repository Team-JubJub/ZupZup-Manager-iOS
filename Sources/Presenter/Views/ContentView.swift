//
//  ContentView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/18.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLogin = false
    @State private var selectedIndex = 0
    let tabBarImangeNames = ["shippingbox", "gearshape"]
    let tabBarNames = ["Menu", "Order"]
    
    var body: some View {
        NavigationView {
            if isLogin {
                VStack(spacing: 0) {
                    ZStack {
                        switch selectedIndex {
                        case 0:
                            let store = ReservationStore()
                            ReservationView(reservationStore: store)
                                .onAppear { store.reduce(action: .fetchReservation) }
                        default:
                            let store = ManageStore()
                            ManageView(store: store)
                        }
                    }
                    Spacer()
                    HStack(spacing: 0) {
                        ForEach(tabBarImangeNames.indices, id: \.self) { num in
                            TabbarItem(
                                symbolName: tabBarImangeNames[num],
                                selectedIndex: $selectedIndex,
                                num: num
                            )
                        }
                    }
                    .frame(height: Device.Height * 84 / 844)
                }
            } else {
                LoginView(isLogin: $isLogin)
            }
        }
    }
}
