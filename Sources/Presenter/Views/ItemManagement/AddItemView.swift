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
                    ZStack {
                        ZStack {
                            Image(uiImage: (addItemStore.selectedImage ?? UIImage(named: "mockImage"))!)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 192)
                                .clipped()
                            
                            Rectangle()
                                .foregroundColor(.designSystem(.ScrimBlack40))
                            
                            Image(assetName: .ic_edit_white)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .scaledToFit()
                        }
                        .onTapGesture {
                            addItemStore.reduce(action: .tabImagePickerButton)
                        }
                        .sheet(isPresented: $addItemStore.isShowingImagePicker) {
                            ImagePicker(selectedImage: $addItemStore.selectedImage)
                        }
                    }
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            SuiteLabel(text: "제품명", typo: .h3)
                            InfiniteSpacer()
                        }
                    }
                    .frame(width: Device.WidthWithPadding)
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            SuiteLabel(text: "가격", typo: .h3)
                            InfiniteSpacer()
                        }
                        
                        HStack(spacing: 0) {
                            SuiteLabel(text: "할인 가격", typo: .body)
                            InfiniteSpacer()
                        }
                        
                        PriceTextField(rightText: $addItemStore.discountPrice)
                    
                        HStack(spacing: 0) {
                            SuiteLabel(text: "가격", typo: .body)
                            InfiniteSpacer()
                        }
                        
                        IvoryRoundedRectangle(width: Device.WidthWithPadding, height: 56)
                    }
                    .frame(width: Device.WidthWithPadding)
                    
                    PriceTextField(rightText: $addItemStore.price)
                    
                    PriceTextField(rightText: $addItemStore.discountPrice)
                    
                    RectangleWithTwoButton(
                        text: "수량",
                        count: $addItemStore.count,
                        minusButtonAction: {
                            addItemStore.reduce(action: .tabMinusButton)
                        },
                        plusButtonAction: {
                            addItemStore.reduce(action: .tabPlusButton)
                        }
                    )
                }
                .onTapGesture {
                    addItemStore.hideKeyboard()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding, trailing: 0))
            
            BottomButton(
                height: Device.Height * 64 / 844,
                text: "등록하기",
                textColor: .designSystem(.pureWhite)!
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
