//
//  AddItemView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Kingfisher

struct AddItemView: View {
    
    @StateObject var addItemStore: AddItemStore
    
    var body: some View {
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
                    ImagePickerView(image: $addItemStore.selectedImage) {
                        addItemStore.reduce(action: .tabImagePickerButton)
                    }
                    .frame(height: 192)
                    .sheet(isPresented: $addItemStore.isShowingImagePicker) {
                        ImagePicker(selectedImage: $addItemStore.selectedImage)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        SuiteLabel(text: "제품명", typo: .h3)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                                                
                        ItemNameTextField(placeHolder: "제품명을 입력해주세요", name: $addItemStore.name) {
                            // TODO: action 정의 필요
                            print("지우기")
                        }
                    }
                    .frame(width: Device.WidthWithPadding)
                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 16, trailing: 0))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        SuiteLabel(text: "가격", typo: .h3)
                        
                        SuiteLabel(text: "할인 가격", typo: .body)
                        
                        PriceTextField(rightText: $addItemStore.price)
                        
                        SuiteLabel(text: "가격", typo: .body)
                            .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                        
                        PriceTextField(rightText: $addItemStore.discountPrice)
                    }
                    .frame(width: Device.WidthWithPadding)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                    
                    VStack(spacing: 4) {
                        HStack(spacing: 0) {
                            SuiteLabel(text: "수량", typo: .h3)
                            InfiniteSpacer()
                        }
                        
                        ItemCountRectangle(
                            count: $addItemStore.count,
                            minusButtonAction: {
                                addItemStore.reduce(action: .tabMinusButton)
                            },
                            plusButtonAction: {
                                addItemStore.reduce(action: .tabPlusButton)
                            }
                        )
                    }
                    .frame(width: Device.WidthWithPadding)
                }
                .onTapGesture {
                    addItemStore.hideKeyboard()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding, trailing: 0))
            
            BottomButton(
                height: Device.Height * 64 / 844,
                text: "등록하기",
                textColor: .designSystem(.pureBlack)!
            ) {
                addItemStore.reduce(action: .tabBottomButton)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .alert(
            "제품 추가",
            isPresented: $addItemStore.isShowingAlert,
            actions: {
                Button("아니오", role: .destructive) {
                    addItemStore.reduce(action: .alertCancelButton)
                }
                Button("네", role: .cancel) {
                    addItemStore.reduce(action: .alertOkButton)
                }
            },
            message: {
                Text("제품을 추가하시겠습니까?")
            }
        )
    }
}
