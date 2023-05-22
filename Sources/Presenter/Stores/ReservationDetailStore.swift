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
    @Published var store: Store
    @Published var isChecked: Bool = false
    
    private let changeStateUseCase: ChangeStateUseCase
    private let updateItemCountUseCase: UpdateItemCountUseCase
    
    init(
        reservation: Reservation,
        store: Store,
        changeStateUseCase: ChangeStateUseCase = ChangeStateUseCaseImpl(),
        updateItemCountUseCase: UpdateItemCountUseCase = UpdateItemCountUseCaseImpl()
    ) {
        self.reservation = reservation
        self.store = store
        self.changeStateUseCase = changeStateUseCase
        self.updateItemCountUseCase = updateItemCountUseCase
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
        case .tabCancelButton:
            self.tabCancelButton()
        case .tabCompleteButton:
            self.tabCompleteButton()
        case .tabRejectButton:
            self.tabRejectButton()
        case .tabComfirmButton:
            self.tabConfirmButton()
        default:
            break
        }
    }
    
    func reduce(action: Action, idx: Int) {
        switch action {
        case .tabMinusButton:
            self.tabMinusButton(idx: idx)
        case.tabPlusButton:
            self.tabPlusButton(idx: idx)
        default:
            break
        }
    }
}

extension ReservationDetailStore {
    
    private func tabPlusButton(idx: Int) {
        self.reservation.cartList[idx].amount += 1
    }
    
    private func tabMinusButton(idx: Int) {
        self.reservation.cartList[idx].amount -= 1
    }
    
    private func tabCancelButton() {
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
    
    private func tabCompleteButton() {
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
    
    private func tabConfirmButton() {
        
        for cart in reservation.cartList {
            if let index = store.items.firstIndex(where: { $0.itemId == cart.itemId }) {
                var item = store.items[index]
                item.amount -= cart.amount
                store.items[index] = item
            }
        }
        
        updateItemCountUseCase.updateItemCount(id: 9, store.items) { result in
            switch result {
            case .success:
                self.changeStateUseCase.changeState(
                    documentID: self.reservation.id,
                    state: .confirm
                ) { result in
                    switch result {
                    case .success: self.reservation.state = .confirm
                    case .failure: break
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func tabRejectButton() {
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
