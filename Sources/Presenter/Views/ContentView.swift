//
//  ContentView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/18.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

// MARK: ContentView
struct ContentView: View {
    // 로그인 여부를 확인하는 변수입니다.
    @State var isLogin = true
    // 탭바 아이템의 인덱스 번호
    @State private var selectedIndex = 0
    // 탭바 아이콘의 정보를 담고 있는 배열
    let tabBarImangeNames: [AssetName] = [ .ic_box_default, .ic_zupzupbag_default, .ic_settings_default]
    // 탭바 아이콘의 이미지를 담고 있는 배열
    let seletedImage: [AssetName] = [.ic_box, .ic_zupzupbag_selected, .ic_settings_selected]
    
    var body: some View {
        NavigationView {
            if isLogin { // MARK: 로그인이 된 상태
                VStack(spacing: 0) {
                    ZStack {
                        // 화면 부분
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
                            let store = StoreManagementStore()
                            StoreManagementView(store: store)
                        }
                    }
                    Spacer()
                    // 탭바 부분
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
            } else { // MARK: 로그인이 되지 않은 상태
                // 로그인 화면 호출
                let store = LoginStore()
                LoginView(store: store, isLogin: $isLogin)
            }
        }
    }
}
