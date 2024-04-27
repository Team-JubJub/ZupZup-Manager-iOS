//
//  Reservation.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//
//
import Foundation
import Combine

import ComposableArchitecture

@Reducer
struct Order {
    var cancelBag = Set<AnyCancellable>()
    
    @Dependency(\.orderClient) var orderClient
    
    struct State: Equatable {
        let tabBarNames = ["신규", "확정", "완료 및 취소"]
        var orders: [OrderEntity] = []
        var filteredOrders: [OrderEntity] = []
        var selectedIndex = 0
        var isLoading = false
    }
    
    enum Action {
        case getAllOrders
        case ordersFetched(Result<[OrderEntity], Error>)
        case tapTabbarItem(Int)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .getAllOrders:
            let storeId = LoginManager.shared.getStoreId()
            
            return .run { send in
                await send(
                    .ordersFetched(
                        Result {
                            let storeID = LoginManager.shared.getStoreId()
                            return try await self.orderClient.getAllOrders(storeID)
                        }
                    )
                )
            }

        case let .ordersFetched(.success(reservations)):
            state.orders = reservations
            state.isLoading = false
            switch state.selectedIndex {
            case 0:
                state.filteredOrders = state.orders.filter { $0.state == .new }
            case 1:
                state.filteredOrders = state.orders.filter { $0.state == .confirm }
            case 2:
                state.filteredOrders = state.orders.filter { $0.state == .complete || $0.state == .cancel }
            default:
                break
            }
            return .none
            
        case let .ordersFetched(.failure(error)):
#if DEBUG
            print("예약 상태 조희 API 호출 실패", error)
#endif
//            switch error {
//            case .tokenExpired:
//                LoginManager.shared.setLoginOff()
//            default:
//                break
//            }
            return .none
            
        case let .tapTabbarItem(num):
            state.selectedIndex = num
            switch state.selectedIndex {
            case 0:
                state.filteredOrders = state.orders.filter { $0.state == .new }
            case 1:
                state.filteredOrders = state.orders.filter { $0.state == .confirm }
            case 2:
                state.filteredOrders = state.orders.filter { $0.state == .complete || $0.state == .cancel }
            default:
                break
            }
            return .none
        }
    }
}

struct OrderClient {
    
    static let getOrderUseCase: GetAllOrdersUseCase = GetAllOrdersUseCaseImpl()
    
    var getAllOrders: (_ storeId: Int)  async throws -> [OrderEntity]
}

extension OrderClient: DependencyKey {
    static let liveValue = Self(
        getAllOrders: { id in
            let response = try await getOrderUseCase.getAllOrders(at: id)
            return response
        }
    )
}

extension DependencyValues {
    var orderClient: OrderClient {
        get { self[OrderClient.self] }
        set { self[OrderClient.self] = newValue }
    }
}
