//
//  ReservationClient.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

import ComposableArchitecture

// State
struct ReservationState: Equatable {
    let tabBarNames = ["신규", "확정", "완료 및 취소"]
    var reservations: [ReservationEntity] = []
    var filteredReservations: [ReservationEntity] = []
    var selectedIndex = 0
    var isLoading = false
}

// Action
enum ReservationAction: Equatable {
    case fetchReservation
    case reservationsFetched(Result<[ReservationEntity], FetchReservationsError>)
    case tapTabbarItem(Int)
}

// Environment
struct ReservationEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var reservations: (FetchReservationsRequest?) -> EffectPublisher<Result<[ReservationEntity], FetchReservationsError>, Never>
}

// Reducer
let reservationReducer = AnyReducer<ReservationState, ReservationAction, ReservationEnvironment> { state, action, environment in
    switch action {
    case .fetchReservation:
        
        let storeId = LoginManager.shared.getStoreId()
        
        let request = FetchReservationsRequest(storeId: 8)
        
        state.isLoading = true
        return environment.reservations(request)
            .map(ReservationAction.reservationsFetched)
            .eraseToEffect()
        
    case let .reservationsFetched(.success(reservations)):
        state.reservations = reservations
        state.isLoading = false
        switch state.selectedIndex {
        case 0:
            state.filteredReservations = state.reservations.filter { $0.state == .new }
        case 1:
            state.filteredReservations = state.reservations.filter { $0.state == .confirm }
        case 2:
            state.filteredReservations = state.reservations.filter { $0.state == .complete || $0.state == .cancel }
        default:
            break
        }
        return .none
        
    case let .reservationsFetched(.failure(error)):
        #if DEBUG
        print("예약 상태 조희 API 호출 실패", error)
        #endif
        switch error {
        case .tokenExpired:
            LoginManager.shared.setLoginOff()
        default:
            break
        }
        return .none
        
    case let .tapTabbarItem(num):
        state.selectedIndex = num
        switch state.selectedIndex {
        case 0:
            state.filteredReservations = state.reservations.filter { $0.state == .new }
        case 1:
            state.filteredReservations = state.reservations.filter { $0.state == .confirm }
        case 2:
            state.filteredReservations = state.reservations.filter { $0.state == .complete || $0.state == .cancel }
        default:
            break
        }
        return .none
    }
}
