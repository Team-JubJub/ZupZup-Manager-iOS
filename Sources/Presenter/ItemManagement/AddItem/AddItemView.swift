//
//  AddItemView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture
import Kingfisher

struct AddItemView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var store: StoreOf<AddItem>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 0) {
                ZStack {
                    HStack(spacing: 0) {
                        NavigationBarWithDismiss(label: "제품 관리")
                        InfiniteSpacer()
                    }
                    .frame(height: 42)
                    
                    HStack(spacing: 0) {
                        InfiniteSpacer()
                        SuiteLabel(text: "제품 등록", typo: .headline)
                        InfiniteSpacer()
                    }
                    .frame(height: 42)
                }
                
                VSpacer(height: 41)
                
                ScrollView {
                    VStack(spacing: 0) {
                        // 이미지 피커 부분
                        ImagePickerView(image: viewStore.$pickerImage) {
                            viewStore.send(.tabImagePickerButton)
                        }
                        .frame(height: 250)
                        .sheet(isPresented: viewStore.binding(get: \.isShowingImagePicker, send: .dismissImagePicker)) {
                            ImagePicker(selectedImage: viewStore.$pickerImage)
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            SuiteLabel(text: "제품명", typo: .h3)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                            
                            ItemNameTextField(
                                placeHolder: "제품명을 입력해주세요",
                                name: viewStore.binding(get: \.name, send: {.nameChanged($0)})
                            ) {
                                viewStore.send(.tabClearButton)
                            }
                        }
                        .frame(width: Device.WidthWithPadding)
                        .padding(EdgeInsets(top: 14, leading: 0, bottom: 16, trailing: 0))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            SuiteLabel(text: "가격", typo: .h3)
                            
                            SuiteLabel(text: "할인 가격", typo: .body)
                            
                            PriceTextField(rightText: viewStore.binding(get: \.discountPrice, send: {.discountChanged($0)}))
                            
                            SuiteLabel(text: "가격", typo: .body)
                                .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                            
                            PriceTextField(rightText: viewStore.binding(get: \.price, send: {.priceChanged($0)}))
                        }
                        .frame(width: Device.WidthWithPadding)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                        
                        VStack(spacing: 4) {
                            HStack(spacing: 0) {
                                SuiteLabel(text: "수량", typo: .h3)
                                InfiniteSpacer()
                            }
                            
                            ItemCountRectangle(
                                count: viewStore.binding(get: \.count, send: {.countChanged($0)}),
                                minusButtonAction: { viewStore.send(.tabMinusButton) },
                                plusButtonAction: { viewStore.send(.tabPlusButton) }
                            )
                        }
                        .frame(width: Device.WidthWithPadding)
                    }
                    .onTapGesture {
                        viewStore.send(.tapEmptySpace)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding, trailing: 0))
                
                BottomButton(
                    height: 64,
                    text: "제품 등록",
                    textColor: .designSystem(.pureBlack)!
                ) {
                    viewStore.send(.tapBottomButton)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .onChange(of: viewStore.isPop) { isPop in
                if isPop { dismiss() }
            }
            
            .alert(
                "제품 추가",
                isPresented: viewStore.binding(get: \.isShowingAlert, send: .dismissAlert),
                actions: {
                    Button("아니오", role: .destructive) { viewStore.send(.alertCancelButton) }
                    Button("네", role: .cancel) { viewStore.send(.alertOkButton) }
                },
                message: { Text("제품을 추가하시겠습니까?") }
            )
            
            .alert(
                viewStore.errorTitle,
                isPresented: viewStore.binding(get: \.isShowingErrorAlert, send: .dismissErrorAlert),
                actions: {
                    Button("확인", role: .cancel) {
                        viewStore.send(.tabErrorAlertOK)
                    }
                },
                message: { Text(viewStore.errorMessage) }
            )
            .overlay {
                if viewStore.isLoading {
                    FullScreenProgressView()
                }
            }
        }
    }
}
