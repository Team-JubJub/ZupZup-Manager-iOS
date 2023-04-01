//
//  ReservationClient.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//
import ComposableArchitecture
import SwiftUI

class ReservationStore: ObservableObject {
    
    @Published var reservations = [Reservation]()
    
    private let fetchReserveUseCase: FetchReserveUseCase
    
    init(
        reservations: [Reservation] = [Reservation](),
        fetchReserveUseCase: FetchReserveUseCase = FetchReserveUseCaseImpl()
    ) {
        self.reservations = reservations
        self.fetchReserveUseCase = fetchReserveUseCase
        self.reduce(action: .fetchReservation)
    }
}

// MARK: Store Protocol 준수
extension ReservationStore: StoreProtocol {
    enum Action {
        case tabNextButton
        case fetchReservation
    }
    
    func reduce(action: Action) {
        switch action {
        case .tabNextButton:
            // TODO:
            break
        case .fetchReservation:
            self.fetchReservations(storeId: 1)
        }
    }
}

// MARK: 비즈니스 로직
extension ReservationStore {
    private func tabNextButton() {
        // TODO: 비즈니스 로직 구현
    }
    
    private func fetchReservations(storeId: Int) {
        fetchReserveUseCase.fetchReserve(storeId: storeId) { result in
            switch result {
            case .success(let reservations):
                self.reservations = reservations
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
