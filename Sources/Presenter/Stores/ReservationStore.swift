//
//  ReservationClient.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class ReservationStore: ObservableObject {
    
    @Published var reservations = [Reservation]()
    @Published var filteredReservations = [Reservation]()
    @Published var store = Store()
    @Published var selectedIndex = 0
    @Published var isLoading: Bool = false
    
    let tabBarNames = ["신규", "확정", "완료 및 취소"]
    
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
        case tapTabbarItem
    }
    
    func reduce(action: Action) {
        switch action {
        case .tabNextButton:
            self.tabNextButton()
        case .fetchReservation:
            self.fetchReservations(storeId: 9)
        case .fetchStore:
            self.fetchStore(storeId: 9)
        default:
            break
        }
    }
    
    func reduce(action: Action, num: Int) {
        switch action {
        case .tapTabbarItem:
            self.tapTabbarItem(num: num)
        default:
            break
        }
    }
}

// MARK: 비즈니스 로직
extension ReservationStore {
    private func tabNextButton() {
        print("tabNextButton")
    }
    
    private func fetchReservations(storeId: Int) {
        self.isLoading = true
        fetchReserveUseCase.fetchReserve(storeId: storeId) { result in
            switch result {
            case .success(let reservations):
                self.reservations = reservations
                
                switch self.selectedIndex {
                case 0:
                    self.filteredReservations = reservations.filter { $0.state == .new }
                case 1:
                    self.filteredReservations = reservations.filter { $0.state == .confirm }
                case 2:
                    self.filteredReservations = reservations.filter { $0.state == .complete || $0.state == .cancel }
                default: break
                }
                self.isLoading = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchStore(storeId: Int) {
        self.isLoading = true
        fetchStoreUseCase.fetchStore(storeId: storeId) { result in
            switch result {
            case .success(let store):
                self.store = store
                self.isLoading = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func tapTabbarItem(num: Int) {
        switch num {
        case 0:
            self.filteredReservations = reservations.filter { $0.state == .new }
        case 1:
            self.filteredReservations = reservations.filter { $0.state == .confirm }
        case 2:
            self.filteredReservations = reservations.filter { $0.state == .complete || $0.state == .cancel }
        default: break
        }
    }
}
