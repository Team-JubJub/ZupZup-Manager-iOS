//
//  ReservationView.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Combine

import ComposableArchitecture

struct ReservationView: View {
    
    let store: StoreOf<Order>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VSpacer(height: Device.VPadding)
            
            VStack(spacing: 8) {
                // MARK: 네비게이션 부분
                LargeNavigationTitle(title: "예약 상황")
                    .padding(
                        EdgeInsets(
                            top: 46,
                            leading: Device.HPadding,
                            bottom: Device.Height * 20 / 844,
                            trailing: Device.HPadding
                        )
                    )
                
                // MARK: 탭바 부분
                HStack(spacing: 0) {
                    ForEach(viewStore.tabBarNames.indices, id: \.self) { num in
                        ReservationStateTabbarItem(
                            selectedIndex: viewStore.binding(get: \.selectedIndex, send: .tapTabbarItem(num)),
                            num: num,
                            name: viewStore.tabBarNames[num]
                        )
                        .onTapGesture {
                            viewStore.send(.tapTabbarItem(num))
                        }
                    }
                }
                .frame(width: Device.WidthWithPadding, height: Device.Height * 44 / 844)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding, trailing: 0))
                
                // MARK: 탭 뷰 부분
                // TODO: Fix 1
                TabView(selection: viewStore.binding(get: \.selectedIndex, send: .tapTabbarItem(1))) {
                    ForEach(viewStore.tabBarNames.indices, id: \.self) { num in
                        VStack(spacing: 0) {
                            ScrollView(showsIndicators: false) {
                                if viewStore.filteredOrders.isEmpty {
                                    VStack(spacing: 0) {
                                        InfiniteSpacer()
                                        EmptyReservationView()
                                        InfiniteSpacer()
                                    }
                                    .frame(width: Device.Width, height: Device.Height / 2, alignment: .center)
                                } else {
                                    ForEach(viewStore.filteredOrders, id: \.self) { reservation in
                                        NavigationLink(
                                            destination: ReserveDetailView(
                                                store: Store(
                                                    initialState: ReservationDetail.State(reservation: reservation)
                                                ) {
                                                    ReservationDetail()
#if DEBUG
                                                        ._printChanges()
#endif
                                                }
                                            )
                                        ) {
                                            ReservationItem(
                                                visitTime: reservation.visitTime,
                                                menu: reservation.orderedItemdName,
                                                orderedTime: reservation.orderedTime,
                                                customer: reservation.customerName,
                                                state: reservation.state
                                            )
                                        }
                                    }
                                }
                            }
                        }
                        .tag(num)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .navigationTitle("")
            .overlay {
                if viewStore.isLoading {
                    FullScreenProgressView()
                }
            }
            .onAppear {
                viewStore.send(.getAllOrders)
            }
        }
    }
}
