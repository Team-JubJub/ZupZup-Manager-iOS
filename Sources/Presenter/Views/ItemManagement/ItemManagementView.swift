//
//  ManageView.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Combine

import ComposableArchitecture
import Kingfisher

struct ItemManagementView: View {
    
    let store: Store<ItemManageState, ItemManageAction>
    
    let columns = [GridItem(), GridItem()]
    
    // MARK: UseCase
    let addItemUseCase: AddItemUseCase = AddItemUseCaseImpl()
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 0) {
                if viewStore.isLoading {
                    RoundCircleProgress()
                } else {
                    HStack(spacing: 0) {
                        LargeNavigationTitle(title: "제품 관리")
                        InfiniteSpacer()
                        EditButton { viewStore.send(.tapEditButton) }
                            .confirmationDialog(
                                "Title",
                                isPresented: viewStore.binding(
                                    get: { $0.isEditable },
                                    send: ItemManageAction.tapEditButton
                                )
                            ) {
                                Button("수량 수정") { viewStore.send(.tapEditCountButton) }
                                Button("제품 정보 수정") { viewStore.send(.tapEditInfoButton) }
                                Button("제품 추가") { viewStore.send(.tapAddItemButton) }
                                Button("취소", role: .cancel) {}
                            }
                            .navigationDestination(isPresented: viewStore.binding(
                                get: { $0.isEditCountVisible },
                                send: ItemManageAction.tapEditCountButton
                            )) {
//                                EditItemCountView(itemManageStore: itemManageStore)
                                EmptyView()
                            }
                            .navigationDestination(isPresented: viewStore.binding(
                                get: { $0.isAddItemVisible },
                                send: ItemManageAction.tapAddItemButton
                            )) {
                                let store = Store<AddItemState, AddItemAction>(
                                    initialState: AddItemState(),
                                    reducer: addItemReducer,
                                    environment: AddItemEnvironment(
                                        addItem: { request in
                                            return Future { promise in
                                                addItemUseCase.addItem(request: request) { result in
                                                    promise(.success(result))
                                                }
                                            }
                                            .eraseToEffect()
                                        }
                                    )
                                )
                                AddItemView(store: store)
                            }
                            .navigationDestination(isPresented: viewStore.binding(
                                get: { $0.isEditInfoVisible },
                                send: ItemManageAction.tapEditInfoButton
                            )) {
                                EmptyView()
//                                EditItemInfoView(itemStore: EditItemInfoStore(items: itemManageStore.store.items))
                            }
                    }
                    .padding(EdgeInsets(top: 46, leading: Device.HPadding, bottom: Device.Height * 20 / 844, trailing: Device.HPadding))
                    
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns) {
                            ForEach(viewStore.items.indices, id: \.self) { index in
                                ProductGridItem(
                                    count: viewStore.state.items[index].amount,
                                    url: viewStore.state.items[index].imageUrl,
                                    title: viewStore.state.items[index].name,
                                    originalPrice: viewStore.state.items[index].priceOrigin,
                                    salePrice: viewStore.state.items[index].priceDiscount,
                                    type: .common
                                )
                            }
                        }
                        .frame(width: Device.WidthWithPadding)
                    }
                }
            }
            .navigationTitle("")
        }
    }
}
