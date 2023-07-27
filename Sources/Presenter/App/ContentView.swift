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
    // 로그인 여부를 확인하는 변수입니다.
    @State var isLogin = false
    // 탭바 아이템의 인덱스 번호
    @State private var selectedIndex = 0
    // 탭바 아이콘의 정보를 담고 있는 배열
    let tabBarImangeNames: [AssetName] = [ .tab_zero_off, .tab_one_off, .tab_two_off]
    // 탭바 아이콘의 이미지를 담고 있는 배열
    let seletedImage: [AssetName] = [.tab_zero_on, .tab_one_on, .tab_two_on]
    // MARK: 유즈케이스
    let openStoreUseCase: OpenStoreUseCase = OpenStoreUseCaseImpl()
    let fetchStoreUseCase: FetchStoreUseCase = FetchStoreUseCaseImpl()
    
    var body: some View {
        NavigationStack {
            if LoginManager.shared.isLoginValid() || isLogin { // MARK: 로그인이 된 상태
                VStack(spacing: 0) {
                    ZStack {
                        // 화면 부분
                        switch selectedIndex {
                        case 0:
                            // MARK: 1본 탭 : 예약 상황 화면
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
                            // MARK: OnAppear 시점에 예약 조회 API 호출
                            ReservationView(store: store)
                                .onAppear {
                                    ViewStore(store).send(.fetchReservation)
                                }
                        case 1:
                            // MARK: 2번 탭 : 제품 관리 화면
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
                            // MARK: OnAppear 시점에 API 호출
                            ItemManagementView(store: store)
                                .onAppear {
                                    ViewStore(store).send(.fetchItems)
                                }
                        default:
                            // MARK: 3번 탭 : 매장 관리 화면
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
                                    },
                                    openCustomerCenterURL: {
                                        UrlManager.shared.openCustomerCenter()
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
                    .frame(height: 50)
                }
            } else { // MARK: 로그인이 되지 않은 상태
                // 로그인 화면 호출
                let store = Store<LoginState, LoginAction>(
                    initialState: LoginState(),
                    reducer: loginReducer,
                    environment: LoginEnvironment(
                        loginRepository: LoginRepository(),
                        login: { request in
                            return Future { promise in
                                LoginRepository().login(request: request) { result in
                                    self.isLogin.toggle()
                                    promise(.success(result))
                                }
                            }
                            .eraseToEffect()
                        }
                    )
                )
                LoginView(store: store, isLogin: $isLogin)
            }
        }
    }
}
