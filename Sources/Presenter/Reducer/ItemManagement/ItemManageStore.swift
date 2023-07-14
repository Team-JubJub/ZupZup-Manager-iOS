//
//  ManageStore.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

class ItemManageStore: ObservableObject {
    
    private let fetchStoreUseCase: FetchStoreUseCase
    private let updateItemCountUseCase: UpdateItemCountUseCase
    
    @Published var store = StoreEntity()
    
    @Published var isEditable: Bool = false
    @Published var isAddable: Bool = false
    @Published var isLoading: Bool = false
    
    @Published var isEditCountVisible = false
    @Published var isAddItemVisible = false
    @Published var isEditInfoVisible = false
    
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
extension ItemManageStore: StoreProtocol {
    
    enum Action {
        case fetchStore
        case tabEditButton // 수정하기 버튼을 눌렀을 경우
        case tabEditBottomButton // 하단 수정하기 버튼을 눌렀을 경우
        case tabPlusButton // 제품 개수 더하기 버튼을 눌렀을 경우
        case tabMinusButton // 제품 개수 빼기 버튼을 눌렀을 경우
        case tabItem // 제품을 눌렀을 경우
        case tapEditCountButton // 수량 수정 버튼을 눌렀을 경우
        case tapAddItemButton // 제품 정보 수정 버튼을 눌렀을 경우
        case tapEditInfoButton // 제품 추가 버튼을 눌렀을 경우
    }
    
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
        case .tapEditCountButton:
            self.tapEditCountButton()
        case .tapAddItemButton:
            self.tapAddItemButton()
        case .tapEditInfoButton:
            self.tapEditInfoButton()
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
}

// MARK: 비즈니스 로직 구현
extension ItemManageStore {
    
    private func fetchStore(storeId: Int) {
        self.isLoading = true
        self.fetchStoreUseCase.fetchStore(storeId: storeId) { result in
            switch result {
            case .success(let store):
                self.store = store
                self.isLoading = false
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
                self.isEditCountVisible = false
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
        if self.store.items[idx].amount > 0 { self.store.items[idx].amount -= 1 }
    }
    
    func updateItem(newItem: ItemEntity) {
        if let index = store.items.firstIndex(where: { $0.itemId == newItem.itemId }) {
            store.items[index] = newItem
        }
    }
    
    func appendItem(item: ItemEntity) {
        self.store.items.append(item)
    }
    
    func deleteItem(itemId: Int) {
        if let index = store.items.firstIndex(where: { $0.itemId == itemId }) {
            self.store.items.remove(at: index)
        }
    }
    
    func getNewItemId() -> Int {
        guard let maxItemId = store.items.max(
            by: { $0.itemId < $1.itemId }
        )?.itemId else {
            return 0
        }
        return maxItemId + 1
    }
    
    func tapEditCountButton() {
        self.isEditCountVisible = true
    }
    
    func tapAddItemButton() {
        self.isAddItemVisible = true
    }
    
    func tapEditInfoButton() {
        self.isEditInfoVisible = true
    }
}
