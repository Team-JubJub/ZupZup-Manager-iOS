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
    let tabBarImangeNames: [AssetName] = [ .ic_box_default, .ic_zupzupbag_default, .ic_settings_default]
    let seletedImage: [AssetName] = [.ic_box, .ic_zupzupbag_selected, .ic_settings_selected]
    
    var body: some View {
        NavigationView {
            if isLogin {
                VStack(spacing: 0) {
                    ZStack {
                        switch selectedIndex {
                        case 0:
                            let store = ReservationStore()
                            ReservationView(reservationStore: store)
                                .onAppear {
                                    store.reduce(action: .fetchReservation)
                                    store.reduce(action: .fetchStore)
                                }
                        case 1:
                            let store = ManageStore()
                            ItemManagementView(manageStore: store)
                        default:
                            StoreManagementView()
                        }
                    }
                    Spacer()
                    HStack(spacing: 0) {
                        ForEach(tabBarImangeNames.indices, id: \.self) { num in
                            TabbarItem(
                                defaultAsset: tabBarImangeNames[num],
                                selectedAsset: seletedImage[num],
                                selectedIndex: $selectedIndex,
                                num: num
                            )
                        }
                    }
                    .frame(height: Device.Height * 84 / 844)
                }
            } else {
                let store = LoginStore()
                LoginView(store: store, isLogin: $isLogin)
            }
        }
    }
}
