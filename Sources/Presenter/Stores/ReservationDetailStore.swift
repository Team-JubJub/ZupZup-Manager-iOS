//
//  ReservationDetailStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/29.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

class ReservationDetailStore: ObservableObject {
    
    @Published var reservation: Reservation
    @Published var isChecked: Bool = false
    
    private let changeStateUseCase: ChangeStateUseCase
    
    init(
        reservation: Reservation,
        changeStateUseCase: ChangeStateUseCase = ChangeStateUseCaseImpl()
    ) {
        self.reservation = reservation
        self.changeStateUseCase = changeStateUseCase
    }
}

extension ReservationDetailStore: StoreProtocol {
    enum Action {
        case tabCheckButton // 예약확인 버튼을 눌렀을 경우
        case tabPlusButton // 제품의 더하기버튼을 눌렀을 경우
        case tabMinusButton // 제품의 빼기버튼을 눌렀을 경우
        case tabCancelButton // 취소 버튼을 눌렀을 경우
        case tabRejectButton // 반려 버튼을 눌렀을 경우
        case tabCompleteButton // 완료 버튼을 눌렀을 경우
        case tabComfirmButton // 확정 버튼을 눌렀을 경우
    }
    
    func reduce(action: Action) {
        switch action {
        case .tabCheckButton:
            self.isChecked = true
        case .tabPlusButton:
            // TODO: 로직 구현
            break
        case .tabMinusButton:
            // TODO: 로직 구현
            break
        case .tabCancelButton:
            self.tabCancelButton()
        case .tabCompleteButton:
            self.tabCompleteButton()
        case .tabRejectButton:
            self.tabRejectButton()
        case .tabComfirmButton:
            self.tabConfirmButton()
        }
    }
}

extension ReservationDetailStore {
    func tabCancelButton() {
        changeStateUseCase.changeState(
            documentID: reservation.id,
            state: .cancel
        ) { result in
                switch result {
                case .success: self.reservation.state = .cancel
                case .failure: break
            }
        }
    }
    
    func tabCompleteButton() {
        changeStateUseCase.changeState(
            documentID: reservation.id,
            state: .complete
        ) { result in
                switch result {
                case .success: self.reservation.state = .complete
                case .failure: break
            }
        }
    }
    
    func tabConfirmButton() {
        changeStateUseCase.changeState(
            documentID: reservation.id,
            state: .confirm
        ) { result in
                switch result {
                case .success: self.reservation.state = .confirm
                case .failure: break
            }
        }
    }
    
    func tabRejectButton() {
        changeStateUseCase.changeState(
            documentID: reservation.id,
            state: .cancel
        ) { result in
                switch result {
                case .success: self.reservation.state = .cancel
                case .failure: break
            }
        }
    }
}
