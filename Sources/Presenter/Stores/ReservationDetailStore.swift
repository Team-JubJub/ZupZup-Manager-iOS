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
    
    init(reservation: Reservation) {
        self.reservation = reservation
    }
}

extension ReservationDetailStore: StoreProtocol {
    enum Action {
        case tabCheckButton // 예약확인 버튼을 눌렀을 경우
        case tabPlusButton // 제품의 더하기버튼을 눌렀을 경우
        case tabMinusButton // 제품의 빼기버튼을 눌렀을 경우
        case tabCancelButton // 반려 버튼을 눌렀을 경우
        case tabConfirmButton // 확정 버튼을 눌렀을 경우
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
            // TODO: 로직 구현
            break
        case .tabConfirmButton:
            // TODO: 로직 구현
            break
        }
    }
}
