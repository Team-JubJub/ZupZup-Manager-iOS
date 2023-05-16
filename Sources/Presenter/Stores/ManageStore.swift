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
    
    @Published var store: Store?
    
    @Published var isEditable: Bool = false
    @Published var isAddable: Bool = false
    
    init(fetchStoreUseCase: FetchStoreUseCase = FetchStoreUseCaseImpl()) {
        self.fetchStoreUseCase = fetchStoreUseCase
    }
}

// MARK: 상태 & 액션 정의 : StoreProtocol
extension ManageStore: StoreProtocol {
    func reduce(action: Action) {
        switch action {
        case .fetchStore:
            self.fetchStore(storeId: 1)
        case .tabEditButton:
            self.tabEditButton()
        case .tabEditBottom:
            self.tabEditBottom()
        case .tabPlusButton:
            // TODO: 비즈니스 로직 구현
            break
        case .tabMinusButton:
            // TODO: 비즈니스 로직 구현
            break
        case .tabItem:
            break
        }
    }
    
    enum Action {
        case fetchStore
        case tabEditButton // 수정하기 버튼을 눌렀을 경우
        case tabEditBottom // 하단 수정하기 버튼을 눌렀을 경우
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
                dump(store)
                self.store = store
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func tabEditButton() {
        withAnimation { self.isEditable = true }
    }
    
    private func tabEditBottom() {
        withAnimation { self.isEditable = false }
    }
}
