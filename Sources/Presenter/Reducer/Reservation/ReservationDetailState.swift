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
    var store: StoreEntity
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
    case bindIsShowingHalfModal // isShowingHalfModal 변수 바인딩 목적
}

struct ReservationDetailEnvironment {
    var changeState: (String, ReservationCondition) -> EffectPublisher<Result<ReservationCondition, NetworkError>, Never>
}

let reservationDetailReducer = AnyReducer<ReservationDetailState, ReservationDetailAction, ReservationDetailEnvironment> { state, action, environment in
    switch action {
    case .tabBottomButton:
        state.isShowingHalfModal = true
        return .none

    case let .tabPlusButton(idx):
        state.reservation.cartList[idx].amount += 1
        return .none

    case let .tabMinusButton(idx):
        if state.reservation.cartList[idx].amount > 0 {
            state.reservation.cartList[idx].amount -= 1
        }
        return .none

    case .tabCancelButton:
        return environment.changeState(state.reservation.id, ReservationCondition.cancel)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()

    case .tabCompleteButton:
        return environment.changeState(state.reservation.id, ReservationCondition.complete)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()

    case .tabRejectButton:
        return environment.changeState(state.reservation.id, ReservationCondition.cancel)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()

    case .tabConfirmButton:
        return environment.changeState(state.reservation.id, ReservationCondition.confirm)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()
        
    case let .updatedCondition(.success(condition)):
        state.reservation.state = condition
        state.isShowingHalfModal = false
        return .none
        
    case let .updatedCondition(.failure(error)):
        #if DEBUG
        print("예약 상태 변경 API 호출 실패", error)
        #endif
        return .none
        
    case .bindIsShowingHalfModal:
        state.isShowingHalfModal = false
        return .none
    }
}
