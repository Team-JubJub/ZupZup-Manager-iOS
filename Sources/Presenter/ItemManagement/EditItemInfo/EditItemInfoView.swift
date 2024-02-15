//
//  EditItemInfoView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/11.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Combine

import ComposableArchitecture

struct EditItemInfoView: View {
    // TODO: Need to move Entity From View
    // TODO: Need To Remove Business Logic from View
    @Environment(\.dismiss) private var dismiss
    @State private var isNavigate: Bool = false
    @State private var selectedItem: ItemEntity?
    
    let store: StoreOf<EditItemInfo>
    
    let columns = [GridItem(), GridItem()]
    
    var body: some View {
        
        WithViewStore(self.store, observe: {$0}) { viewStore in
            ZStack {
                VStack(spacing: 0) {
                    NavigationBarWithDismiss(label: "제품 관리")
                    
                    HStack(spacing: 0) {
                        LargeNavigationTitle(title: "정보 수정")
                        InfiniteSpacer()
                    }
                    .padding(EdgeInsets(top: 2, leading: Device.HPadding, bottom: Device.Height * 20 / 844, trailing: Device.HPadding))
                    
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns) {
                            ForEach(viewStore.state.items, id: \.self) { item in
                                ProductGridItem(
                                    count: item.count,
                                    url: item.imageUrl,
                                    title: item.name,
                                    originalPrice: item.priceOrigin,
                                    salePrice: item.priceDiscount,
                                    type: .editInfo
                                )
                                .onTapGesture {
                                    tabItem(item)
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        .frame(width: Device.WidthWithPadding)
                        
                        VSpacer(height: 64)
                    }
                    VSpacer(height: 50)
                }
                
                VStack(spacing: 0) {
                    InfiniteSpacer()
                    BottomButton(height: 64, text: "수정 완료", textColor: .designSystem(.pureBlack)!) {
                        viewStore.send(.tapBottomButton)
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("")
            .overlay {
                if viewStore.isLoading {
                    FullScreenProgressView()
                }
            }
            .onChange(of: viewStore.isPop) { isPop in
                if isPop { dismiss() }
            }
            .sheet(isPresented: $isNavigate) {
                if let item = self.selectedItem {
                    EditItemInfoDetailView(store: Store(initialState: EditItemInfoDetail.State(item)) {
                        EditItemInfoDetail()
#if DEBUG
                            ._printChanges()
#endif
                    }) .onDisappear {
                        viewStore.send(.fetchItems)
                    }
                    
                }
            }
        }
    }
}

extension EditItemInfoView {
    func tabItem(_ item: ItemEntity) {
        self.selectedItem = item
        self.isNavigate = true
    }
}
