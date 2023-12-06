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
    
    @ObservedObject var loginManager = LoginManager.shared
    
    @State private var selectedIndex = 0                                                    // 탭바 아이템의 인덱스 번호
    
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
                            let store = Store<ReservationState, ReservationAction>(
                                initialState: ReservationState(),
                                reducer: reservationReducer,
                                environment: ReservationEnvironment(
                                    mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                                    reservations: { request in
                                        return Future { promise in
                                            FetchReserveUseCaseImpl()
                                                .fetchReserve(request: request) { result in
                                                    promise(.success(result))
                                                }
                                        }
                                        .eraseToEffect()
                                    }
                                )
                            )
                            ReservationView(store: store)                                   // MARK: OnAppear 시점에 예약 조회 API 호출
                                .onAppear {
                                    ViewStore(store).send(.fetchReservation)
                                }
                        case 1:                                                             // MARK: 2번 탭 : 제품 관리 화면
                            let store = Store<ItemManageState, ItemManageAction>(
                                initialState: ItemManageState(),
                                reducer: itemManageReducer,
                                environment: ItemManageEnvironment(
                                    items: {
                                        return Future { promise in
                                            FetchItemsUseCaseImpl()
                                                .fetchItems { result in
                                                    promise(.success(result))
                                                }
                                        }
                                        .eraseToEffect()
                                    }
                                )
                            )
                            ItemManagementView(store: store)                                // MARK: OnAppear 시점에 API 호출
                                .onAppear {
                                    ViewStore(store).send(.fetchItems)
                                }
                        default:                                                            // MARK: 3번 탭 : 매장 관리 화면
                            let store = Store<StoreManagementState, StoreManagementAction>(
                                initialState: StoreManagementState(),
                                reducer: storeManagementReducer,
                                environment: StoreManagementEnvironment(
                                    openStore: { request in
                                        return Future { promise in
                                            openStoreUseCase.openStore(request: request) { result in
                                                promise(.success(result))
                                            }
                                        }
                                        .eraseToEffect()
                                    },
                                    fetchStore: {
                                        return Future { promise in
                                            fetchStoreUseCase.fetchStore { result in
                                                promise(.success(result))
                                            }
                                        }
                                        .eraseToEffect()
                                    }
                                )
                            )
                            StoreManagementView(store: store)
                                .onAppear {
                                    ViewStore(store).send(.fetchStore)
                                }
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
                let store = Store<LoginState, LoginAction>(
                    initialState: LoginState(),
                    reducer: loginReducer,
                    environment: LoginEnvironment(
                        loginRepository: LoginRepository(),
                        login: { request in
                            return Future { promise in
                                LoginRepository().login(request: request) { result in
                                    promise(.success(result))
                                }
                            }
                            .eraseToEffect()
                        }
                    )
                )
                LoginView(store: store)
            }
        }
    }
}
