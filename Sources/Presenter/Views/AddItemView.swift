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
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var addItemStore: AddItemStore
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBarWithDismiss(label: "제품 관리")
            VSpacer(height: Device.Height * 2 / 844)
            
            HStack(spacing: 0) {
                LargeTitleLabel(title: "제품 등록")
                Spacer()
            }
            .frame(width: Device.Width * 358 / 390)
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: Device.HPadding,
                    bottom: Device.VPadding * 2,
                    trailing: Device.HPadding
                )
            )
            
            ScrollView {
                VStack(spacing: Device.VPadding) {
                    ZStack {
                        ZStack {
                            
                            Image(uiImage: (addItemStore.selectedImage ?? UIImage(named: "mockImage"))!)
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: Device.WidthWithPadding,
                                    height: Device.WidthWithPadding
                                )
                                .cornerRadius(Device.cornerRadious)
                                .clipped()
                            
                        }
                        
                        GeometryReader { geometry in
                            ImagePickerButton {
                                addItemStore.reduce(action: .tabImagePickerButton)
                            }
                            .offset(
                                x: geometry.size.width - 88,
                                y: geometry.size.height - 72
                            )
                            .sheet(isPresented: $addItemStore.isShowingImagePicker) {
                                ImagePicker(selectedImage: $addItemStore.selectedImage)
                            }
                        }
                    }
                    
                    RectangleWithTwoLabel(leftText: "메뉴", rightText: $addItemStore.name, textType: .text)
                    
                    RectangleWithTwoLabel(leftText: "판매가격", rightText: $addItemStore.priceString, textType: .number)
                    
                    RectangleWithTwoLabel(leftText: "할인가격", rightText: $addItemStore.discountString, textType: .number)
                    
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
                textColor: .designSystem(.OffWhite)!
            ) {
                addItemStore.reduce(action: .tabBottomButton)
                dismiss()
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}
