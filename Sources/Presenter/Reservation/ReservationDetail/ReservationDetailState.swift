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

// MARK: TCA - State
struct ReservationDetailState: Equatable {
    // 예약 관련
    var reservation: ReservationEntity // 단건 예약
    // 모달 관련
    var isShowingHalfModal: Bool = false // 하프 모달 트리거
    // API 관련
    var isLoading: Bool = false // API 호출시 indicator 트리거
    
    var isShowingAlert: Bool = false
}

// MARK: TCA - Action
enum ReservationDetailAction: Equatable {
    // 버튼 관련
    case tabBottomButton // 예약 확정하기 버튼을 눌렀을 경우
    case tabPlusButton(Int) // 아이템의 + 버튼을 눌렀을 경우
    case tabMinusButton(Int) // 아이템의 - 버튼을 눌렀을 경우
    case tabCancelButton // 취소 버튼을 눌렀을 경우
    case tabCompleteButton // 완료 버튼을 눌렀을 경우
    case tabRejectButton // 반려 버튼을 눌렀을 경우
    case tabConfirmButton // 화정 버튼을 눌렀을 경우
    
    case dismissAlert
    case cancelAlert
    
    // API 관련
    case updatedCondition(Result<ReservationCondition, ChangeStateError>) // 예약 상태 변경 API 리턴
    
    // 모달 관련
    case bindIsShowingHalfModal // isShowingHalfModal 변수 바인딩
}

// MARK: TCA - Environment
struct ReservationDetailEnvironment {
    var changeState: (ChangeStateRequest) -> EffectPublisher<Result<ReservationCondition, ChangeStateError>, Never>
    var changeJustState: (ChangeJustStateRequest) -> EffectPublisher<Result<ReservationCondition, ChangeStateError>, Never>
}

// MARK: TCA - Reducer
let reservationDetailReducer = AnyReducer<ReservationDetailState, ReservationDetailAction, ReservationDetailEnvironment> { state, action, environment in
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
        // '상태만' 바꾸는 API호출
        let request = state.reservation.toJustChangeStateRequest(state: .cancel)
        state.isLoading = true
        return environment.changeJustState(request)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()
        
    case .tabCompleteButton: // 확정 상태 - 완료 버튼을 눌렀을 경우
        // '상태만' 바꾸는 API호출
        let request = state.reservation.toJustChangeStateRequest(state: .complete)
        state.isLoading = true
        return environment.changeJustState(request)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()
        
    case .tabRejectButton: // 확정 상태 - 반려 버튼을 눌렀을 경우
        // 상테 + 개수 반영 API
        let request = state.reservation.toChangeStateRequest(state: .cancel)
        state.isLoading = true
        return environment.changeState(request)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()

    case .tabConfirmButton: // 확정 상태 - 완료 버튼을 눌렀을 경우
        // 상테 + 개수 반영 API
        let request = state.reservation.toChangeStateRequest(state: .confirm)
        state.isLoading = true
        return environment.changeState(request)
            .map(ReservationDetailAction.updatedCondition)
            .eraseToEffect()
    
    // API 관련
    case let .updatedCondition(.success(condition)): // 예약 상태 변경 API - 성공
        state.reservation.state = condition
        state.isShowingHalfModal = false
        state.isLoading = false
        return .none
        
    case let .updatedCondition(.failure(error)): // 예약 상태 변경 API - 실패
        switch error {
        case .tokenExpired:
            LoginManager.shared.setLoginOff()
        case .badRequest:
            state.isShowingAlert = true
        default:
            break
        }
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
    }
}
