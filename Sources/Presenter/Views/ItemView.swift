//
//  ItemView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                LargeTitleLabel(title: "초코 크로와상")
                Spacer()
                TrashTongButton {
                    // TODO: 비즈니스 로직 : 삭제 버튼 눌렀을 경우
                    print("tab TrashTong")
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
                        Image(assetName: .mockImage)
                            .resizable()
                            .frame(
                                width: Device.WidthWithPadding,
                                height: Device.WidthWithPadding
                            )
                            .cornerRadius(Device.cornerRadious)
                        
                        GeometryReader { geometry in
                            ImagePickerButton {
                                // TODO: 비즈니스로직 - 이미지 피커 눌렀을 경우
                                print("tab ImagePickerButton")
                            }
                            .offset(
                                x: geometry.size.width - 88,
                                y: geometry.size.height - 72
                            )
                        }
                    }
                    
                    RectangleWithTwoLabel(leftText: "메뉴", rightText: "초코 크로와상")
                    
                    RectangleWithTwoLabel(leftText: "판매가격", rightText: "3,000원")
                    
                    RectangleWithTwoLabel(leftText: "할인가격", rightText: "1,500원")
                    
                    RectangleWithTwoButton(
                        text: "수량",
                        minusButtonAction: {
                            // TODO: 비즈니스 로직 - 마이너스 버튼을 탭한 경우
                            print("tab minusButtonAction")
                        },
                        plusButtonAction: {
                            // TODO: 비즈니스 로직 - 플러스 버튼을 탭한 경우
                            print("tab plusButtonAction")
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
