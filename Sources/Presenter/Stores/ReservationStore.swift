//
//  ReservationClient.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//
import ComposableArchitecture
import SwiftUI

class ReservationStore: ObservableObject, StoreProtocol {
    
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
    
    enum Action {
        case tabNextButton
        case fetchReservation
    }
    
    func reduce(action: Action) {
        switch action {
        case .tabNextButton:
            print("tabbed")
        case .fetchReservation:
            self.fetchReservations(storeId: 1)
        }
    }
}

extension ReservationStore {
    private func tabNextButton() {
        
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

protocol StoreProtocol {
    associatedtype Action
    func reduce(action: Action)
}
