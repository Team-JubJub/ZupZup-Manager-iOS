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
    @Published var store = Store()
    
    private let fetchReserveUseCase: FetchReserveUseCase
    private let fetchStoreUseCase: FetchStoreUseCase
    
    init(
        reservations: [Reservation] = [Reservation](),
        fetchReserveUseCase: FetchReserveUseCase = FetchReserveUseCaseImpl(),
        fetchStoreUseCase: FetchStoreUseCase = FetchStoreUseCaseImpl()
    ) {
        self.reservations = reservations
        self.fetchReserveUseCase = fetchReserveUseCase
        self.fetchStoreUseCase = fetchStoreUseCase
    }
}

// MARK: Store Protocol 준수
extension ReservationStore: StoreProtocol {
    enum Action {
        case tabNextButton
        case fetchReservation
        case fetchStore
    }
    
    func reduce(action: Action) {
        switch action {
        case .tabNextButton:
            self.tabNextButton()
        case .fetchReservation:
            self.fetchReservations(storeId: 9)
        case .fetchStore:
            self.fetchStore(storeId: 9)
        }
    }
}

// MARK: 비즈니스 로직
extension ReservationStore {
    private func tabNextButton() {
        print("tabNextButton")
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
    
    private func fetchStore(storeId: Int) {
        fetchStoreUseCase.fetchStore(storeId: storeId) { result in
            switch result {
            case .success(let store):
                self.store = store
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
