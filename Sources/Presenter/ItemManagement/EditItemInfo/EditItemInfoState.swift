////
////  ItemStore.swift
////  ZupZupManager
////
////  Created by YeongJin Jeong on 2023/05/16.
////  Copyright © 2023 ZupZup. All rights reserved.
////
//
//import SwiftUI
//
//import ComposableArchitecture
//
//// MARK: TCA - State
//struct EditItemInfoState: Equatable {
//    // 제품 관련
//    var items: [ItemEntity]
//    
//    // 네비게이션 관련
//    var isPop: Bool = false
//    
//    var isLoading = false // 로딩 인디케이터 호출
//}
//
//// MARK: TCA - Action
//enum EditItemInfoAction: Equatable {
//    // 버튼 관련
//    case tapBottomButton // 수정 완료 버튼을 눌렀을 경우
//    
//    case fetchItems      // 제품 패치
//    case itemsFetched(Result<[ItemEntity], FetchItemsError>) // 아이템 호출 결과
//}
//
//// MARK: TCA - Environment
//struct EditItemInfoEnvironment { 
//    var items: () -> EffectPublisher<Result<[ItemEntity], FetchItemsError>, Never>
//}
//
//// MARK: TCA - Reducer
//let editItemInfoReducer = AnyReducer<EditItemInfoState, EditItemInfoAction, EditItemInfoEnvironment> { state, action, environment in
//    
//    switch action {
//    // 버튼 관련
//    case .tapBottomButton: // 수정 완료 버튼을 눌렀을 경우
//        state.isPop = true
//        return .none
//        
//    case .fetchItems: // 제품 리스트 호출
//        state.isLoading = true
//        return environment.items()
//            .map(EditItemInfoAction.itemsFetched)
//            .eraseToEffect()
//        
//    case let .itemsFetched(.success(items)): // 제품 리스트 호출 성공
//        state.items = items
//        state.isLoading = false
//        return .none
//        
//    case let .itemsFetched(.failure(error)): // 제품 리스트 호출 실패
//        switch error {
//        case .tokenExpired:
//            LoginManager.shared.setLoginOff()
//        default:
//            break
//        }
//        state.isLoading = false
//        return .none
//        
//    }
//}
