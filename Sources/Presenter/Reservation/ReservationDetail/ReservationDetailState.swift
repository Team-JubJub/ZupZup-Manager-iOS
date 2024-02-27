////
////  ReservationDetailStore.swift
////  ZupZupManager
////
////  Created by YeongJin Jeong on 2023/03/29.
////  Copyright © 2023 ZupZup. All rights reserved.
////
//
//import SwiftUI
//import Combine
//
//import ComposableArchitecture
//
import Foundation

import ComposableArchitecture

@Reducer
struct ReservationDetail {
    
    @Dependency(\.reservationDetailClient) var reservationDetailClient
    
    struct State: Equatable {
        var reservation: OrderEntity // 단건 예약
        var isShowingHalfModal: Bool = false // 하프 모달 트리거
        var isLoading: Bool = false // API 호출시 indicator 트리거
        var isShowingAlert: Bool = false
        var isConfirmAlertOn: Bool = false
        var isCancelAlertOn: Bool = false
        var isCompleteAlertOn: Bool = false
        var isRejectAlertOn: Bool = false
    }
    
    enum Action {
        case tabBottomButton // 예약 확정하기 버튼을 눌렀을 경우
        case tabPlusButton(Int) // 아이템의 + 버튼을 눌렀을 경우
        case tabMinusButton(Int) // 아이템의 - 버튼을 눌렀을 경우
        case tabCancelButton // 취소 버튼을 눌렀을 경우
        case tabCompleteButton // 완료 버튼을 눌렀을 경우
        case tabRejectButton // 반려 버튼을 눌렀을 경우
        case tabConfirmButton // 화정 버튼을 눌렀을 경우
        case dismissAlert
        case cancelAlert
        case dismissConfirmAlert
        case dismissCancelAlert
        case dismissCompleteAlert
        case dismissRejectAlert
        case tabConfirmAlertOK
        case tabCancelAlertOK
        case tabCompleteAlertOK
        case tabRejectAlertOK
        case tabConfirmAlertNO
        case tabCancelAlertNO
        case tabCompleteAlertNO
        case tabRejectAlertNO
        case updatedCondition(Result<ReservationCondition, Error>)
        case bindIsShowingHalfModal // isShowingHalfModal 변수 바인딩
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            // 버튼 관련
        case .tabBottomButton: // 예약 확정하기 버튼을 눌렀을 경우
            state.isShowingHalfModal = true
            return .none
            
        case let .tabPlusButton(idx): // 아이템의 + 버튼을 눌렀을 경우
            state.reservation.cartList[idx].amount += 1
            return .none
            
        case let .tabMinusButton(idx): // 아이템의 - 버튼을 눌렀을 경우
            if state.reservation.cartList[idx].amount > 0 {
                state.reservation.cartList[idx].amount -= 1
            }
            return .none
            
        case .tabCancelButton: // 신규 상태 - 취소 버튼을 눌렀을 경우
            state.isCancelAlertOn = true
            return .none
            
        case .tabCompleteButton: // 확정 상태 - 완료 버튼을 눌렀을 경우
            state.isCompleteAlertOn = true
            return .none
            
        case .tabRejectButton: // 확정 상태 - 반려 버튼을 눌렀을 경우
            state.isRejectAlertOn = true
            return .none
            
        case .tabConfirmButton: // 확정 상태 - 완료 버튼을 눌렀을 경우
            state.isConfirmAlertOn = true
            return .none
            
            // API 관련
        case let .updatedCondition(.success(condition)): // 예약 상태 변경 API - 성공
            state.reservation.state = condition
            state.isShowingHalfModal = false
            state.isLoading = false
            return .none
            
        case let .updatedCondition(.failure(error)): // 예약 상태 변경 API - 실패
//            switch error {
//            case .tokenExpired:
//                LoginManager.shared.setLoginOff()
//            case .badRequest:
//                state.isShowingAlert = true
//            default:
//                break
//            }
            state.isLoading = false
#if DEBUG
            print("예약 상태 변경 API 호출 실패", error)
#endif
            return .none
            
            // 모달 관련
        case .bindIsShowingHalfModal: // isShowingHalfModal 변수 바인딩
            state.isShowingHalfModal = false
            return .none
            
        case .dismissAlert:                           // isShowingAlert 바인딩
            state.isShowingAlert = false
            return .none
            
        case .cancelAlert:
            return .none
            
        case .dismissConfirmAlert:
            state.isConfirmAlertOn = false
            return .none
            
        case .dismissCancelAlert:
            state.isCancelAlertOn = false
            return .none
            
        case .dismissCompleteAlert:
            state.isCompleteAlertOn = false
            return .none
            
        case .dismissRejectAlert:
            state.isRejectAlertOn = false
            return .none
            
        case .tabConfirmAlertOK:
            // 상테 + 개수 반영 API
            let request = state.reservation.toChangeStateRequest(state: .confirm)
            state.isLoading = true
            
            return .run { send in
                await send (
                    .updatedCondition(
                        Result {
                            try await self.reservationDetailClient.changeState(request)
                        }
                    )
                )
            }
            
        case .tabCancelAlertOK:
            // '상태만' 바꾸는 API호출
            let request = state.reservation.toJustChangeStateRequest(state: .cancel)
            state.isLoading = true
            
            return .run { send in
                await send (
                    .updatedCondition(
                        Result {
                            try await self.reservationDetailClient.changeJustState(request)
                        }
                    )
                )
            }
            
        case .tabCompleteAlertOK:
            // '상태만' 바꾸는 API호출
            let request = state.reservation.toJustChangeStateRequest(state: .complete)
            state.isLoading = true
            
            return .run { send in
                await send (
                    .updatedCondition(
                        Result {
                            try await self.reservationDetailClient.changeJustState(request)
                        }
                    )
                )
            }
            
        case .tabRejectAlertOK:
            // 상테 + 개수 반영 API
            let request = state.reservation.toChangeStateRequest(state: .cancel)
            state.isLoading = true
            
            return .run { send in
                await send (
                    .updatedCondition(
                        Result {
                            try await self.reservationDetailClient.changeState(request)
                        }
                    )
                )
            }
            
        case .tabConfirmAlertNO:
            state.isConfirmAlertOn = false
            return .none
            
        case .tabCancelAlertNO:
            state.isCancelAlertOn = false
            return .none
            
        case .tabCompleteAlertNO:
            state.isCompleteAlertOn = false
            return .none
            
        case .tabRejectAlertNO:
            state.isRejectAlertOn = false
            return .none
        }
    }
}

struct ReservationDetailClient {
    var changeState: (ChangeStateRequest) async throws -> ReservationCondition
    var changeJustState: (ChangeJustStateRequest) async throws -> ReservationCondition
}

extension ReservationDetailClient: DependencyKey {
    static let liveValue = Self(
        changeState: { request in
            let response = try await ChangeStateRepositoryImpl().changeState(request: request).toCondition()
            return response
        },
        changeJustState: { request in
            let response = try await ChangeJustStateRepositoryImpl().changeState(request: request).toCondition()
            return response
        }
    )
}

extension DependencyValues {
    var reservationDetailClient: ReservationDetailClient {
        get { self[ReservationDetailClient.self] }
        set { self[ReservationDetailClient.self] = newValue }
    }
}
