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
        ZStack {
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
                                store.reduce(action: .tapImagePicker)
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
                            AdjustTimeView(
                                isShowingStartPicker: $store.isShowingOpenTimePicker,
                                isShowingEndPicker: $store.isShowingCloseTimePicker,
                                startTime: $store.openTime,
                                startMinute: $store.openMinute,
                                endTime: $store.closeTime,
                                endMinute: $store.closeMinute,
                                mode: .open,
                                startAction: { store.reduce(action: .tapOpenStartTime) },
                                endAction: { store.reduce(action: .tapOpenEndTime) }
                            )
                        }
                        .frame(width: Device.WidthWithPadding)
                        
                        VStack(spacing: 8) {
                            HStack(spacing: 0) {
                                SuitLabel(text: "할인 시간", typo: .h3)
                                InfiniteSpacer()
                            }
                            AdjustTimeView(
                                isShowingStartPicker: $store.isShowingDiscountStartTimePicker,
                                isShowingEndPicker: $store.isShowingDiscountEndTimePicker,
                                startTime: $store.discountStartTime,
                                startMinute: $store.discountStartMinute,
                                endTime: $store.discountEndTime,
                                endMinute: $store.discountEndMinute,
                                mode: .discount,
                                startAction: { store.reduce(action: .tapDiscountStartTime) },
                                endAction: { store.reduce(action: .tapDiscountEndTime) }
                            )
                        }
                        .frame(width: Device.WidthWithPadding)
                        
                        VStack(spacing: 8) {
                            HStack(spacing: 0) {
                                SuitLabel(text: "휴무일", typo: .h3)
                                InfiniteSpacer()
                            }
                            SelectDaysView(days: $store.daysOfWeek) { idx in
                                store.reduce(action: .tapDaysButton, idx: idx)
                            }
                        }
                        .frame(width: Device.WidthWithPadding)
                    }
                    VSpacer(height: 136)
                }
            }
            
            VStack(spacing: 0) {
                InfiniteSpacer()
                BottomButton(height: 64, text: "수정 완료", textColor: .designSystem(.pureBlack)!) {
                    store.reduce(action: .tapBottomButton)
                }
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
    }
}
