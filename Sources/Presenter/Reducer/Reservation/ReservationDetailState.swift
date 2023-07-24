//
//  ReservationDetailStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/29.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Combine

import ComposableArchitecture

struct ReservationDetailState: Equatable {
    var reservation: ReservationEntity
    var isShowingHalfModal: Bool = false
}

enum ReservationDetailAction: Equatable {
    case tabBottomButton // 예약 확정하기 버튼을 눌렀을 경우
    case tabPlusButton(Int) // 아이템의 + 버튼을 눌렀을 경우
    case tabMinusButton(Int) // 아이템의 - 버튼을 눌렀을 경우
    case tabCancelButton // 취소 버튼을 눌렀을 경우
    case tabCompleteButton // 완료 버튼을 눌렀을 경우
    case tabRejectButton // 반려 버튼을 눌렀을 경우
    case tabConfirmButton // 화정 버튼을 눌렀을 경우
    case updatedCondition(Result<ReservationCondition, NetworkError>) // 예약 상태 변경 API 리턴
    case bindIsShowingHalfModal // isShowingHalfModal 변수 바인딩
}

struct ReservationDetailEnvironment {
    var changeState: (ChangeStateRequest) -> EffectPublisher<Result<ReservationCondition, NetworkError>, Never>
    var changeJustState: (ChangeJustStateRequest) -> EffectPublisher<Result<ReservationCondition, NetworkError>, Never>
}

let reservationDetailReducer = AnyReducer<ReservationDetailState, ReservationDetailAction, ReservationDetailEnvironment> { state, action, environment in
    switch action {
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
        // '상태만' 바꾸는 API호출
        let request = state.reservation.toJustChangeStateRequest(state: .cancel)
        return environment.changeJustState(request)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()
        
    case .tabCompleteButton: // 확정 상태 - 완료 버튼을 눌렀을 경우
        // '상태만' 바꾸는 API호출
        let request = state.reservation.toJustChangeStateRequest(state: .complete)
        return environment.changeJustState(request)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()
        
    case .tabRejectButton: // 확정 상태 - 반려 버튼을 눌렀을 경우
        // 상테 + 개수 반영 API
        let request = state.reservation.toChangeStateRequest(state: .cancel)
        return environment.changeState(request)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()

    case .tabConfirmButton: // 확정 상태 - 완료 버튼을 눌렀을 경우
        // 상테 + 개수 반영 API
        let request = state.reservation.toChangeStateRequest(state: .confirm)
        return environment.changeState(request)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()
        
    case let .updatedCondition(.success(condition)): // 예약 상태 변경 API - 성공
        state.reservation.state = condition
        state.isShowingHalfModal = false
        return .none
        
    case let .updatedCondition(.failure(error)): // 예약 상태 변경 API - 실패
        #if DEBUG
        print("예약 상태 변경 API 호출 실패", error)
        #endif
        return .none
        
    case .bindIsShowingHalfModal: // isShowingHalfModal 변수 바인딩
        state.isShowingHalfModal = false
        return .none
    }
}
