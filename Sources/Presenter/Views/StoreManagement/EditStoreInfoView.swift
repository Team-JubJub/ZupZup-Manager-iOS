//
//  EditStoreInfoView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/13.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct EditStoreInfoView: View {
    
    @StateObject var store: EditStoreInfoStore
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack(spacing: 0) {
                    NavigationBarWithDismiss(label: "설정")
                    InfiniteSpacer()
                }
                .frame(height: 42)
                
                HStack(spacing: 0) {
                    InfiniteSpacer()
                    SuiteLabel(text: "가게 정보", typo: .headline)
                    InfiniteSpacer()
                }
                .frame(height: 42)
            }
            
            ScrollView {
                VStack(spacing: 16) {
                    VStack(spacing: 0) {
                        ImagePickerView(image: $store.selectedImage) {
                            // TODO: 이미지 피커 로직 구현
                        }
                        .frame(height: 192)
                        .sheet(isPresented: $store.isShowingImagePicker) {
                            ImagePicker(selectedImage: $store.selectedImage)
                        }
                        .frame(height: 235)
                    }
                    
                    VStack(spacing: 8) {
                        HStack(spacing: 0) {
                            SuitLabel(text: "영업 시간", typo: .h3)
                            InfiniteSpacer()
                        }
                        ZStack {
                            IvoryRoundedRectangle(width: Device.WidthWithPadding, height: store.isShowingOpenTimePicker ? 200 : 65)
                            GeometryReader { _ in
                                HStack(spacing: 0) {
                                    Button {
                                        store.reduce(action: .tapOpenTimeStart)
                                    } label: {
                                        VStack(alignment: .leading, spacing: 0) {
                                            SuitLabel(text: "영업 시간", typo: .captionSmall, color: .designSystem(.Tangerine300))
                                            SuiteLabel(text: "09:00", typo: .headline)
                                        }
                                    }
                                    InfiniteSpacer()
                                    Button {
                                        store.reduce(action: .tapOpenTimeEnd)
                                    } label: {
                                        VStack(alignment: .leading, spacing: 0) {
                                            SuitLabel(text: "마감 시간", typo: .captionSmall, color: .designSystem(.Tangerine300))
                                            SuiteLabel(text: "21:00", typo: .headline)
                                        }
                                    }
                                    InfiniteSpacer()
                                }
                                .frame(width: Device.WidthWithPadding - Device.HPadding * 2, height: 33)
                                .offset(x: Device.HPadding, y: Device.VPadding)
                                
                                if store.isShowingOpenTimePicker {
                                    Rectangle()
                                        .foregroundColor(.designSystem(.ivoryGray200))
                                        .frame(width: Device.WidthWithPadding, height: 1)
                                        .offset(y: 65)
                                }
                                
                                HStack(spacing: 30) {
                                    
                                }
                            }
                        }
                    }
                    .frame(width: Device.WidthWithPadding)
                    
                    VStack(spacing: 8) {
                        HStack(spacing: 0) {
                            SuitLabel(text: "할인 시간", typo: .h3)
                            InfiniteSpacer()
                        }
                        IvoryRoundedRectangle(width: Device.WidthWithPadding, height: 65)
                    }
                    .frame(width: Device.WidthWithPadding)
                    
                    VStack(spacing: 8) {
                        HStack(spacing: 0) {
                            SuitLabel(text: "휴무일", typo: .h3)
                            InfiniteSpacer()
                        }
                        IvoryRoundedRectangle(width: Device.WidthWithPadding, height: 65)
                    }
                    .frame(width: Device.WidthWithPadding)
                }
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
    }
}
