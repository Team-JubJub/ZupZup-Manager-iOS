//
//  EditItemInfoDetailView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/11.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct EditItemInfoDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let store: Store<EditItemDetailState, EditItemDetailAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 0) {
                VSpacer(height: 12)
                
                ZStack {
                    // 네비게이션 타이틀
                    HStack(spacing: 0) {
                        InfiniteSpacer()
                        SuiteLabel(text: "제품 정보", typo: .headline)
                        InfiniteSpacer()
                    }
                    .frame(height: 42)
                    
                    // 우측 상단 쓰레기통 모양 버튼
                    HStack(spacing: 0) {
                        InfiniteSpacer()
                        TrashTongButton {
                            viewStore.send(.tapTrashTongButton)
                        }
                    }
                }
                
                VSpacer(height: 41)
                
                ScrollView {
                    VStack(spacing: 0) {
                        ImagePickerView(
                            image: viewStore.binding(
                                get: { $0.selectedImage },
                                send: EditItemDetailAction.selectedImageChanged
                            ),
                            imageUrl: viewStore.state.imageUrl
                        ) {
                            viewStore.send(.tabImagePickerButton)
                        }
                        .frame(height: 250)
                        .sheet(
                            isPresented: viewStore.binding(
                                get: { $0.isShowingImagePicker },
                                send: EditItemDetailAction.dismissImagePicker
                            )
                        ) {
                            ImagePicker(
                                selectedImage: viewStore.binding(
                                    get: { $0.selectedImage },
                                    send: EditItemDetailAction.selectedImageChanged
                                )
                            )
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            SuiteLabel(text: "제품명", typo: .h3)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                                                    
                            ItemNameTextField(
                                placeHolder: viewStore.state.name,
                                name: viewStore.binding(
                                    get: { $0.name },
                                    send: EditItemDetailAction.nameChanged
                                )
                            ) {
                                viewStore.send(.tabClearButton)
                            }
                        }
                        .frame(width: Device.WidthWithPadding)
                        .padding(EdgeInsets(top: 14, leading: 0, bottom: 16, trailing: 0))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            SuiteLabel(text: "가격", typo: .h3)
                            
                            SuiteLabel(text: "할인 가격", typo: .body)
                            
                            PriceTextField(
                                rightText: viewStore.binding(
                                    get: { $0.discountPrice },
                                    send: EditItemDetailAction.discountChanged
                                )
                            )
                            
                            SuiteLabel(text: "가격", typo: .body)
                                .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                            
                            PriceTextField(
                                rightText: viewStore.binding(
                                    get: { $0.price },
                                    send: EditItemDetailAction.priceChanged
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
                                    send: EditItemDetailAction.countChanged
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
                    height: 64,
                    text: "등록하기",
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
                "제품 삭제",
                isPresented: viewStore.binding(
                    get: { $0.isShowingAlert },
                    send: EditItemDetailAction.dismissDeleteAlert
                ),
                actions: {
                    Button("삭제", role: .destructive) { viewStore.send(.deleteAlertOk) }
                    Button("아니오", role: .cancel) { viewStore.send(.deleteAlertCancel) }
                },
                message: { Text("제품을 리스트에서 삭제합니다.") }
            )
            
            .alert(
                "제품 정보 수정",
                isPresented: viewStore.binding(
                    get: { $0.isShowingEditAlert },
                    send: EditItemDetailAction.dismissEditAlert
                ),
                actions: {
                    Button("확인") { viewStore.send(.EditAlertOk) }
                    Button("취소", role: .cancel) { viewStore.send(.EditAlertCancel) }
                },
                message: { Text("제품 수정을 완료합니다.") }
            )
            
            .alert(
                "텍스트 초과",
                isPresented: viewStore.binding(
                    get: { $0.isShowingTitleMaxLengthAlert },
                    send: EditItemDetailAction.dismissMaxLengthAlert
                ),
                actions: {
                    Button("확인", role: .cancel) { }
                },
                message: { Text("입력 가능한 제품명은 최대 20자 입니다.") }
            )
            .overlay {
                if viewStore.isLoading {
                    FullScreenProgressView()
                }
            }
        }
    }
}
