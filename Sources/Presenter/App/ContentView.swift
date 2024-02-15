//
//  ContentView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/18.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Combine

// MARK: ContentView
struct ContentView: View {
    // TODO: Need To Refactor to TCA
    
    @ObservedObject var loginManager = LoginManager.shared
    
    @State private var selectedIndex = 0                                                   // 탭바 아이템의 인덱스 번호
    
    let tabBarImangeNames: [AssetName] = [.tab_zero_off, .tab_one_off, .tab_two_off]       // 탭바 아이콘의 정보를 담고 있는 배열
    
    let seletedImage: [AssetName] = [.tab_zero_on, .tab_one_on, .tab_two_on]                // 탭바 아이콘의 이미지를 담고 있는 배열
    
    let openStoreUseCase: OpenStoreUseCase = OpenStoreUseCaseImpl()                         // MARK: 유즈케이스
    
    let fetchStoreUseCase: FetchStoreUseCase = FetchStoreUseCaseImpl()
    
    var body: some View {
        NavigationStack {
            if loginManager.isLogin {                              // MARK: 로그인이 된 상태
                VStack(spacing: 0) {
                    ZStack {
                        switch selectedIndex {
                        case 0:                                                             // MARK: 1번 탭 : 예약 상황 화면
                            ReservationView(
                                store: Store(initialState: Reservation.State()) {
                                    Reservation()
                                    #if DEBUG
                                        ._printChanges()
                                    #endif
                                }
                            )
                        case 1:                                                             // MARK: 2번 탭 : 제품 관리 화면
                            ItemManagementView(
                                store: Store(initialState: ItemManagement.State()) {
                                    ItemManagement()
                                    #if DEBUG
                                        ._printChanges()
                                    #endif
                                }
                            )
                        default:                                                            // MARK: 3번 탭 : 매장 관리 화면
                            StoreManagementView(store: Store(initialState: StoreManagement.State()){
                                StoreManagement()
                                #if DEBUG
                                    ._printChanges()
                                #endif
                            })
                        }
                    }
                    Spacer()
                    
                    HStack(spacing: 0) {                                                    // 탭바 부분
                        ForEach(tabBarImangeNames.indices, id: \.self) { num in
                            TabbarItem(
                                defaultAsset: tabBarImangeNames[num],
                                selectedAsset: seletedImage[num],
                                selectedIndex: $selectedIndex,
                                num: num
                            )
                        }
                    }
                    .frame(height: 50)
                }
            } else {                                                                        // MARK: 로그인이 되지 않은 상태
                LoginView(
                    store: Store(initialState: Login.State()) {
                        Login()
#if DEBUG
                            ._printChanges()
#endif
                    }
                )
            }
        }
    }
}
