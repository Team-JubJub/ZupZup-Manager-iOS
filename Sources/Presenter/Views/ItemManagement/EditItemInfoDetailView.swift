//
//  EditItemInfoDetailView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/11.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct EditItemInfoDetailView: View {
    
    @StateObject var store: EditItemDetailStore
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // 네비게이션바 뒤로가기 버튼
                HStack(spacing: 0) {
                    NavigationBarWithDismiss(label: "제품 관리")
                    InfiniteSpacer()
                }
                .frame(height: 42)
                
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
                        store.reduce(action: .tapTrashTongButton)
                    }
                }
            }
            
            VSpacer(height: 41)
            
            ScrollView {
                VStack(spacing: 0) {
                    ImagePickerView(image: $store.selectedImage, imageUrl: store.imageUrl) {
                        store.reduce(action: .tabImagePickerButton)
                    }
                    .frame(height: 192)
                    .sheet(isPresented: $store.isShowingImagePicker) {
                        ImagePicker(selectedImage: $store.selectedImage)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        SuiteLabel(text: "제품명", typo: .h3)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                                                
                        ItemNameTextField(placeHolder: store.name, name: $store.name) {
                            // TODO: action 정의 필요
                            print("지우기")
                        }
                    }
                    .frame(width: Device.WidthWithPadding)
                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 16, trailing: 0))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        SuiteLabel(text: "가격", typo: .h3)
                        
                        SuiteLabel(text: "할인 가격", typo: .body)
                        
                        PriceTextField(rightText: $store.priceDiscount)
                        
                        SuiteLabel(text: "가격", typo: .body)
                            .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                        
                        PriceTextField(rightText: $store.priceOrigin)
                    }
                    .frame(width: Device.WidthWithPadding)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                    
                    VStack(spacing: 4) {
                        HStack(spacing: 0) {
                            SuiteLabel(text: "수량", typo: .h3)
                            InfiniteSpacer()
                        }
                        
                        ItemCountRectangle(
                            count: $store.count,
                            minusButtonAction: {
                                store.reduce(action: .tabMinusButton)
                            },
                            plusButtonAction: {
                                store.reduce(action: .tabPlusButton)
                            }
                        )
                    }
                    .frame(width: Device.WidthWithPadding)
                }
                .onTapGesture {
                    store.hideKeyboard()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding, trailing: 0))
            
            BottomButton(
                height: Device.Height * 64 / 844,
                text: "등록하기",
                textColor: .designSystem(.pureBlack)!
            ) {
                store.reduce(action: .tabBottomButton)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .alert(
            "제품 삭제",
            isPresented: $store.isShowingAlert,
            actions: {
                Button("삭제", role: .destructive) {
                    store.reduce(action: .tapAlertDelete)
                }
                Button("아니오", role: .cancel) {
                    store.reduce(action: .tapAlertCancel)
                }
            },
            message: {
                Text("제품을 리스트에서 삭제합니다.")
            }
        )
    }
}
