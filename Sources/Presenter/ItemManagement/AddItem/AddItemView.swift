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
    
    var store: Store<AddItemState, AddItemAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
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
                        ImagePickerView(
                            image: viewStore.binding(
                                get: { $0.selectedImage },
                                send: AddItemAction.selectedImageChanged
                            )
                        ) {
                            viewStore.send(.tabImagePickerButton)
                        }
                        .frame(height: 192)
                        .sheet(
                            isPresented: viewStore.binding(
                                get: { $0.isShowingImagePicker },
                                send: AddItemAction.dismissImagePicker
                            )
                        ) {
                            ImagePicker(
                                selectedImage: viewStore.binding(
                                    get: { $0.selectedImage },
                                    send: AddItemAction.selectedImageChanged
                                )
                            )
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            SuiteLabel(text: "제품명", typo: .h3)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                            
                            ItemNameTextField(
                                placeHolder: "제품명을 입력해주세요",
                                name: viewStore.binding(
                                    get: { $0.name },
                                    send: AddItemAction.nameChanged
                                )
                            ) {
                                // TODO: action 정의 필요
                                print("지우기")
                            }
                        }
                        .frame(width: Device.WidthWithPadding)
                        .padding(EdgeInsets(top: 14, leading: 0, bottom: 16, trailing: 0))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            SuiteLabel(text: "가격", typo: .h3)
                            
                            SuiteLabel(text: "할인 가격", typo: .body)
                            
                            PriceTextField(
                                rightText: viewStore.binding(
                                    get: { $0.price },
                                    send: AddItemAction.priceChanged
                                )
                            )
                            
                            SuiteLabel(text: "가격", typo: .body)
                                .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                            
                            PriceTextField(
                                rightText: viewStore.binding(
                                    get: { $0.discountPrice },
                                    send: AddItemAction.discountChanged
                                )
                            )
                        }
                        .frame(width: Device.WidthWithPadding)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                        
                        VStack(spacing: 4) {
                            HStack(spacing: 0) {
                                SuiteLabel(text: "수량", typo: .h3)
                                InfiniteSpacer()
                            }
                            
                            ItemCountRectangle(
                                count: viewStore.binding(
                                    get: { $0.count },
                                    send: AddItemAction.countChanged
                                ),
                                minusButtonAction: {
                                    viewStore.send(.tabMinusButton)
                                },
                                plusButtonAction: {
                                    viewStore.send(.tabPlusButton)
                                }
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
                    height: Device.Height * 64 / 844,
                    text: "제품 등록",
                    textColor: .designSystem(.pureBlack)!
                ) {
                    viewStore.send(.tapBottomButton)
                }
            }
            .overlay {
                FullScreenProgressView()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .alert(
                "제품 추가",
                isPresented: viewStore.binding(
                    get: { $0.isShowingAlert },
                    send: AddItemAction.dismissAlert
                ),
                actions: {
                    Button("아니오", role: .destructive) {
                        viewStore.send(.alertCancelButton)
                    }
                    Button("네", role: .cancel) {
                        viewStore.send(.alertOkButton)
                    }
                },
                message: {
                    Text("제품을 추가하시겠습니까?")
                }
            )
        }
    }
}
