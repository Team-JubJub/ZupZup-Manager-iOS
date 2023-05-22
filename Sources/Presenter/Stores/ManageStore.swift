//
//  ManageStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class ManageStore: ObservableObject {
    
    private let fetchStoreUseCase: FetchStoreUseCase
    private let updateItemCountUseCase: UpdateItemCountUseCase
    
    @Published var store = Store()
    
    @Published var isEditable: Bool = false
    @Published var isAddable: Bool = false
    
    init(
        fetchStoreUseCase: FetchStoreUseCase = FetchStoreUseCaseImpl(),
        updateItemCountUseCase: UpdateItemCountUseCase = UpdateItemCountUseCaseImpl()
    ) {
        self.fetchStoreUseCase = fetchStoreUseCase
        self.updateItemCountUseCase = updateItemCountUseCase
        self.reduce(action: .fetchStore)
    }
}

// MARK: 상태 & 액션 정의 : StoreProtocol
extension ManageStore: StoreProtocol {
    func reduce(action: Action) {
        switch action {
        case .fetchStore:
            self.fetchStore(storeId: 9)
        case .tabEditButton:
            self.tabEditButton()
        case .tabEditBottomButton:
            self.tabEditBottomButton()
        case .tabItem:
            break
        default:
            break
        }
    }
    
    func reduce(action: Action, idx: Int) {
        switch action {
        case .tabPlusButton:
            self.tabPlusButton(idx: idx)
        case .tabMinusButton:
            self.tabMinusButton(idx: idx)
        default:
            break
        }
    }
    
    enum Action {
        case fetchStore
        case tabEditButton // 수정하기 버튼을 눌렀을 경우
        case tabEditBottomButton // 하단 수정하기 버튼을 눌렀을 경우
        case tabPlusButton // 제품 개수 더하기 버튼을 눌렀을 경우
        case tabMinusButton // 제품 개수 빼기 버튼을 눌렀을 경우
        case tabItem // 제품을 눌렀을 경우
    }
}

// MARK: 비즈니스 로직 구현
extension ManageStore {
    
    private func fetchStore(storeId: Int) {
        self.fetchStoreUseCase.fetchStore(storeId: storeId) { result in
            switch result {
            case .success(let store):
                self.store = store
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func tabEditButton() {
        withAnimation { self.isEditable = true }
    }
    
    private func tabEditBottomButton() {
        self.updateItemCountUseCase.updateItemCount(id: 9, self.store.items) { result in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        withAnimation { self.isEditable = false }
    }
    
    private func tabPlusButton(idx: Int) {
        self.store.items[idx].amount += 1
    }
    
    private func tabMinusButton(idx: Int) {
        self.store.items[idx].amount -= 1
    }
}
