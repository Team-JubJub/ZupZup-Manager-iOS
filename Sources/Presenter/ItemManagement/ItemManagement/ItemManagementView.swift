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
    
    let store: StoreOf<ItemManagement>
    
    let columns = [GridItem(), GridItem()]
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    LargeNavigationTitle(title: "제품 관리")
                    InfiniteSpacer()
                    EditButton { viewStore.send(.tapEditButton) }
                        .confirmationDialog(
                            "Title",
                            isPresented: viewStore.binding(get: \.isEditable, send: .dismissEditButton)
                        ) {
                            if viewStore.items.isEmpty {
                                Button("제품 추가") { viewStore.send(.tapAddItemButton) }
                                Button("취소", role: .cancel) {}
                            } else {
                                Button("수량 수정") { viewStore.send(.tapEditCountButton) }
                                Button("제품 정보 수정") { viewStore.send(.tapEditInfoButton) }
                                Button("제품 추가") { viewStore.send(.tapAddItemButton) }
                                Button("취소", role: .cancel) {}
                            }
                        }
                    // TODO: Connect Child View
                        .navigationDestination(isPresented: viewStore.binding(get: \.isNavigate, send: .dismissTarget)) {
                            switch viewStore.targetViewType {
                            case .addItem:
                                makeAddItemView()
                                    .onDisappear { viewStore.send(.fetchItems) }
                            case .editItemCount:
                                makeEditItemCountView(items: viewStore.items)
                            case .editItemInfo:
                                makeEditItemInfoView(items: viewStore.items)
                            }
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
            .onAppear {
                viewStore.send(.fetchItems)
            }
        }
    }
}

// TODO: Connect ChildView
extension ItemManagementView {
    @ViewBuilder
    func makeAddItemView() -> some View {
        AddItemView(
            store: Store(initialState: AddItem.State()) {
                AddItem()
                #if DEBUG
                    ._printChanges()
                #endif
            }
        )
    }
    
    @ViewBuilder
    func makeEditItemInfoView(items: [ItemEntity]) -> some View {
        EditItemInfoView(store: Store(initialState: EditItemInfo.State(items: items)) {
            EditItemInfo()
            #if DEBUG
                ._printChanges()
            
            #endif
        })
    }
    
    @ViewBuilder
    func makeEditItemCountView(items: [ItemEntity]) -> some View {
        EditItemCountView(store: Store(initialState: EditItemCount.State(items: items)){
            EditItemCount()
            #if DEBUG
                ._printChanges()
            #endif
        })
    }
}
