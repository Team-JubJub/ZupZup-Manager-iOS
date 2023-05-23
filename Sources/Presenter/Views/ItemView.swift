//
//  ItemView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    
    @StateObject var itemStore: ItemStore
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                LargeTitleLabel(title: itemStore.item.name)
                Spacer()
                TrashTongButton {
                    itemStore.reduce(action: .tabTrashTong)
                }
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
                        // TODO: 이미지 피커로 교체
                        Image(uiImage: (itemStore.selectedImage ?? UIImage(named: "mockImage"))!)
                            .resizable()
                            .frame(
                                width: Device.WidthWithPadding,
                                height: Device.WidthWithPadding
                            )
                            .cornerRadius(Device.cornerRadious)
                        
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
                    
                    RectangleWithTwoLabel(leftText: "메뉴", rightText: itemStore.item.name)
                    
                    RectangleWithTwoLabel(leftText: "판매가격", rightText: "\(itemStore.item.priceOrigin)원")
                    
                    RectangleWithTwoLabel(leftText: "할인가격", rightText: "\(itemStore.item.priceDiscount)원")
        
                    RectangleWithTwoButton(
                        text: "수량",
                        minusButtonAction: {
                            itemStore.reduce(action: .tabMinusButton)
                        },
                        plusButtonAction: {
                            itemStore.reduce(action: .tabPlusButton)
                        }
                    )
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding, trailing: 0))
            
            BottomButton(
                height: Device.Height * 64 / 844,
                text: "수정하기",
                textColor: .designSystem(.OffWhite)!
            )
        }
    }
}
