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
    let updateItemCountUseCase: UpdateItemCountUseCase = UpdateItemCountUseCaseImpl()
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    LargeNavigationTitle(title: "제품 관리")
                    InfiniteSpacer()
                    EditButton { viewStore.send(.tapEditButton) }
                        .confirmationDialog(
                            "Title",
                            isPresented: viewStore.binding(
                                get: { $0.isEditable },
                                send: ItemManageAction.dismissEditButton
                            )
                        ) {
                            Button("수량 수정") { viewStore.send(.tapEditCountButton) }
                            Button("제품 정보 수정") { viewStore.send(.tapEditInfoButton) }
                            Button("제품 추가") { viewStore.send(.tapAddItemButton) }
                            Button("취소", role: .cancel) {}
                        }
                        .navigationDestination(isPresented: viewStore.binding(
                            get: { $0.isEditCountVisible },
                            send: ItemManageAction.dismissEditCountButton
                        )) {
                            let store = Store<EditItemCountState, EditItemCountAction>(
                                initialState: EditItemCountState(items: viewStore.state.items),
                                reducer: editItemCountReducer,
                                environment: EditItemCountEnvironment(
                                    updateItemCount: { request in
                                        return Future { promise in
                                            updateItemCountUseCase.updateItemCount(request: request) { result in
                                                promise(.success(result))
                                            }
                                        }
                                        .eraseToEffect()
                                    }
                                )
                            )
                            
                            EditItemCountView(store: store)
                        }
                        .navigationDestination(isPresented: viewStore.binding(
                            get: { $0.isAddItemVisible },
                            send: ItemManageAction.dismissAddItemButton
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
                            send: ItemManageAction.dismissEditInfoButton
                        )) {
                            let store = Store<EditItemInfoState, EditItemInfoAction>(
                                initialState: EditItemInfoState(items: viewStore.state.items),
                                reducer: editItemInfoReducer,
                                environment: EditItemInfoEnvironment(
                                    items: {
                                        return Future { promise in
                                            FetchItemsUseCaseImpl()
                                                .fetchItems { result in
                                                    promise(.success(result))
                                                }
                                        }
                                        .eraseToEffect()
                                    }
                                )
                            )
                            EditItemInfoView(store: store)
                        }
                }
                .padding(EdgeInsets(top: 46, leading: Device.HPadding, bottom: Device.Height * 20 / 844, trailing: Device.HPadding))
                
                ScrollView(showsIndicators: false) {
                    if viewStore.items.isEmpty {
                        VStack(spacing: 0) {
                            InfiniteSpacer()
                            EmptyItemView()
                            InfiniteSpacer()
                        }
                        .frame(width: Device.Width, height: Device.Height * 0.55, alignment: .center)
                    } else {
                        LazyVGrid(columns: columns) {
                            ForEach(viewStore.items.indices, id: \.self) { index in
                                ProductGridItem(
                                    count: viewStore.state.items[index].count,
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
            .overlay {
                if viewStore.isLoading {
                    FullScreenProgressView()
                }
            }
        }
    }
}
