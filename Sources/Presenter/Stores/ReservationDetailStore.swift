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
        case tabCheckButton
        case tabPlusButton
        case tabMinusButton
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
        }
    }
}
