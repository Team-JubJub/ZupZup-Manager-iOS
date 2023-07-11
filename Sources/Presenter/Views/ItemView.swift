//
//  ItemView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ItemView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var itemStore: ItemStore
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBarWithDismiss(label: "제품 관리")
            VSpacer(height: Device.Height * 2 / 844)
            
            HStack(spacing: 0) {
                LargeNavigationTitle(title: itemStore.item.name)
                Spacer()
                TrashTongButton {
                    itemStore.reduce(action: .tabTrashTong)
                }
                .alert(
                    "제품 관리",
                    isPresented: $itemStore.isShowingAlert,
                    actions: {
                        Button("삭제", role: .destructive) {
                            itemStore.reduce(action: .tabAlertDelete)
                            dismiss()
                        }
                        Button("아니오", role: .cancel) {
                            itemStore.reduce(action: .tabAlertCancel)
                        }
                    },
                    message: {
                        Text("제품을 리스트에서 삭제합니다.")
                    }
                )
                .alert(
                    "앗!",
                    isPresented: $itemStore.isShowingEmptyAlert,
                    actions: {
                        Button("확인", role: .cancel) {
                        }
                    },
                    message: {
                        Text("제품의 이름을 추가해주세요.")
                    }
                )
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
                            if itemStore.selectedImage == nil {
                                KFImage(URL(string: itemStore.item.imageUrl))
                                    .placeholder {
                                        Image(assetName: .ic_mockImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(
                                                width: Device.WidthWithPadding,
                                                height: Device.WidthWithPadding
                                            )
                                            .cornerRadius(Device.cornerRadious)
                                            .clipped()
                                    }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: Device.WidthWithPadding,
                                        height: Device.WidthWithPadding
                                    )
                                    .cornerRadius(Device.cornerRadious)
                                    .clipped()
                            } else {
                                Image(uiImage: (itemStore.selectedImage ?? UIImage(named: "ic_mockImage"))!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: Device.WidthWithPadding,
                                        height: Device.WidthWithPadding
                                    )
                                    .cornerRadius(Device.cornerRadious)
                                    .clipped()
                            }
                            
                        }
                        
                        GeometryReader { geometry in
                            ImagePickerButton {
                                itemStore.reduce(action: .tabImagePickerButton)
                            }
                            .offset(
                                x: geometry.size.width - 88,
                                y: geometry.size.height - 72
                            )
                            .sheet(isPresented: $itemStore.isShowingImagePicker) {
                                ImagePicker(selectedImage: $itemStore.selectedImage)
                            }
                        }
                    }
                    
                    ItemCountRectangle(
                        count: $itemStore.item.amount,
                        minusButtonAction: {
                            itemStore.reduce(action: .tabMinusButton)
                        },
                        plusButtonAction: {
                            itemStore.reduce(action: .tabPlusButton)
                        }
                    )
                }
                .onTapGesture {
                    itemStore.hideKeyboard()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding, trailing: 0))
            
            BottomButton(
                height: Device.Height * 64 / 844,
                text: "수정하기",
                textColor: .designSystem(.pureWhite)!
            ) {
                itemStore.reduce(action: .tabBottomButton)
                itemStore.reduce(action: .checkTextfieldEmpty)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}
