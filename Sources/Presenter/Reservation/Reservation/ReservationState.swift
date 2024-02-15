////
////  ReservationClient.swift
////  ZupZupManager
////
////  Created by YeongJin Jeong on 2023/03/25.
////  Copyright © 2023 ZupZup. All rights reserved.
////
//
import Foundation

import ComposableArchitecture

@Reducer
struct Reservation {
    struct State: Equatable {
        let tabBarNames = ["신규", "확정", "완료 및 취소"]
        var reservations: [ReservationEntity] = []
        var filteredReservations: [ReservationEntity] = []
        var selectedIndex = 0
        var isLoading = false
    }
    
    enum Action {
        case fetchReservation
        case reservationsFetched(Result<[ReservationEntity], Error>)
        case tapTabbarItem(Int)
    }
    
    @Dependency(\.reservationClient) var reservationClient
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchReservation:
            
            let storeId = LoginManager.shared.getStoreId()
            
            let request = FetchReservationsRequest(storeId: storeId)
            
            state.isLoading = true
            
            return .run { send in
                await send (
                    .reservationsFetched(Result { try await self.reservationClient.fetchReservations(request)})
                )
            }
            
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
//            switch error {
//            case .tokenExpired:
//                LoginManager.shared.setLoginOff()
//            default:
//                break
//            }
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
}

struct ReservationClient {
    var fetchReservations: (FetchReservationsRequest) async throws -> [ReservationEntity]
}

extension ReservationClient: DependencyKey {
    static let liveValue = Self(
        fetchReservations: { request  in
            let response = try await FetchReservationsRepositoryImpl().fetchReservations(request: request).toReservations()
            return response
        }
    )
}

extension DependencyValues {
    var reservationClient: ReservationClient {
        get { self[ReservationClient.self] }
        set { self[ReservationClient.self] = newValue }
    }
}
