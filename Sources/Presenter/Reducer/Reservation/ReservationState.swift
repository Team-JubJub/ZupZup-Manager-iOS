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
    var store: StoreEntity = StoreEntity()
    var selectedIndex = 0
    var isLoading = false
}

// Action
enum ReservationAction: Equatable {
    case fetchReservation
    case fetchStore
    case storeFetched(Result<StoreEntity, NetworkError>)
    case reservationsFetched(Result<[ReservationEntity], NetworkError>)
    case tapTabbarItem(Int)
}

// Environment
struct ReservationEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var store: (Int) -> EffectPublisher<Result<StoreEntity, NetworkError>, Never>
    var reservations: (FetchReservationsRequest?) -> EffectPublisher<Result<[ReservationEntity], NetworkError>, Never>
}

// Reducer
let reservationReducer = AnyReducer<ReservationState, ReservationAction, ReservationEnvironment> { state, action, environment in
    switch action {
    case .fetchReservation:
        state.isLoading = true
        return environment.reservations(nil)
            .map(ReservationAction.reservationsFetched)
            .eraseToEffect()
        
    case .fetchStore:
        state.isLoading = true
        return environment.store(9)
            .map(ReservationAction.storeFetched)
            .eraseToEffect()
        
    case let .storeFetched(.success(store)):
        state.store = store
        state.isLoading = false
        return .none
        
    case let .storeFetched(.failure(error)):
        #if DEBUG
        print("가게정보 조희 API 호출 실패 : ", error)
        #endif
        state.isLoading = false
        return .none
        
    case let .reservationsFetched(.success(reservations)):
        state.reservations = reservations
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
