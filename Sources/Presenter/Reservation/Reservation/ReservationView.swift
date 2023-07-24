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
    
    let store: Store<ReservationState, ReservationAction>
    
    // MARK: UseCase
    let changeJustStateUseCase: ChangeJustStateUseCase = ChangeJustStateUseCaseImpl()
    let changeStateUseCase: ChangeStateUseCase = ChangeStateUseCaseImpl()
    
    var body: some View {
        WithViewStore(store) { viewStore in
            if viewStore.isLoading {
                RoundCircleProgress()
            } else {
                VSpacer(height: Device.VPadding)
                VStack(spacing: 8) {
                    LargeNavigationTitle(title: "예약 상황")
                        .padding(
                            EdgeInsets(
                                top: 46,
                                leading: Device.HPadding,
                                bottom: Device.Height * 20 / 844,
                                trailing: Device.HPadding
                            )
                        )
                    
                    HStack(spacing: 0) {
                        ForEach(viewStore.tabBarNames.indices, id: \.self) { num in
                            ReservationStateTabbarItem(
                                selectedIndex: viewStore.binding(get: \.selectedIndex, send: ReservationAction.tapTabbarItem),
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
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(viewStore.filteredReservations, id: \.self) { reservation in
                            NavigationLink(
                                destination: ReserveDetailView(
                                    store: Store<ReservationDetailState, ReservationDetailAction>(
                                        initialState: ReservationDetailState(
                                            reservation: reservation
                                        ),
                                        reducer: reservationDetailReducer,
                                        environment: ReservationDetailEnvironment(
                                            changeState: { request in
                                                return Future { promise in
                                                    changeStateUseCase.changeState(request: request) { result in
                                                        promise(.success(result))
                                                    }
                                                }
                                                .eraseToEffect()
                                            },
                                            changeJustState: { request in
                                                return Future { promise in
                                                    changeJustStateUseCase.changeJustState(request: request) { result in
                                                        promise(.success(result))
                                                    }
                                                }
                                                .eraseToEffect()
                                            }
                                        )
                                    )
                                )
                            ) {
                                ReservationItem(
                                    date: reservation.date,
                                    menu: reservation.orderedItemdName,
                                    time: reservation.orderedTime,
                                    customer: reservation.customerName,
                                    state: reservation.state
                                )
                            }
                        }
                    }
                }
                .navigationTitle("")
            }
        }
    }
}
