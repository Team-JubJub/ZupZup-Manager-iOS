//
//  EditStoreInfoView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/13.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct EditStoreInfoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var store: StoreOf<EditStoreInfo>
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
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
                                
                                ImagePickerView(
                                    // MARK: 이미지 피커 변수 바인딩
                                    image: viewStore.binding(get: \.selectedImage, send: {.selectedImageChanged($0)}),
                                    imageUrl: viewStore.state.storeImageUrl
                                ) {
                                    viewStore.send(.tapImagePicker)  // MARK: Action - 이미지 피커를 누른 경우
                                }
                                .frame(height: 250)
                                .sheet(
                                    // MARK: 이미지 피커 변수 바인딩
                                    isPresented: viewStore.binding(get: \.isShowingImagePicker, send: .dismissImagePicker)
                                ) {
                                    // MARK: 이미지 피커 호출
                                    ImagePicker(
                                        selectedImage: viewStore.binding(get: \.selectedImage, send: {.selectedImageChanged($0)})
                                    )
                                }
                                .frame(height: 235)
                            }
                            
                            VStack(spacing: 8) {
                                HStack(spacing: 0) {
                                    SuitLabel(text: "영업 시간", typo: .h3)
                                    InfiniteSpacer()
                                }
                                // MARK: 가게 영업 시작 시간, 종료 시간 Time-Picker
                                AdjustTimeView(
                                    isShowingStartPicker: viewStore.binding(get: \.isShowingOpenTimePicker, send: .dismissOpenTimePicker),
                                    isShowingEndPicker: viewStore.binding(get: \.isShowingCloseTimePicker, send: .dismissCloseTimePicker),
                                    // 영업 시작(시간)
                                    startTime: viewStore.binding(get: \.openTime, send: {.openTimeChanged($0)}),
                                    // 영업 시작(분)
                                    startMinute: viewStore.binding(get: \.openMinute, send: {.openMinuteChanged($0)}),
                                    // 영업 종료(시간)
                                    endTime: viewStore.binding(get: \.closeTime, send: {.closeTimeChanged($0)}),
                                    // 영업 종료(분)
                                    endMinute: viewStore.binding(get: \.closeMinute, send: {.closeMinuteChanged($0)}),
                                    mode: .open,
                                    startAction: { viewStore.send(.tapOpenStartTime, animation: .default) },
                                    endAction: { viewStore.send(.tapOpenEndTime, animation: .default) }
                                )
                            }
                            .frame(width: Device.WidthWithPadding)
                            
                            VStack(spacing: 8) {
                                HStack(spacing: 0) {
                                    SuitLabel(text: "할인 시간", typo: .h3)
                                    InfiniteSpacer()
                                }
                                // MARK: 마감 할인 시작 시간, 종료 시간 Time-Picker
                                AdjustTimeView(
                                    isShowingStartPicker: viewStore.binding(get: \.isShowingDiscountStartTimePicker, send: .dismissDiscountStartTimePicker),
                                    isShowingEndPicker: viewStore.binding(get: \.isShowingDiscountEndTimePicker, send: .dismissDiscountEndTimePicker),
                                    // 마감 할인 시작(시간)
                                    startTime: viewStore.binding(get: \.discountStartTime, send: {.discountStartTimeChanged($0)}),
                                    // 마감 할인 시작(분)
                                    startMinute: viewStore.binding(get: \.discountStartMinute, send: {.discountStartMinuteChanged($0)}),
                                    // 마감 할인 종료 (시간)
                                    endTime: viewStore.binding(get: \.discountEndTime, send: {.discountEndTimeChanged($0)}),
                                    // 마감 할인 종료(분)
                                    endMinute: viewStore.binding(get: \.discountEndMinute, send: {.discountEndMinuteChanged($0)}),
                                    mode: .discount,
                                    startAction: { viewStore.send(.tapDiscountStartTime, animation: .default) },
                                    endAction: { viewStore.send(.tapDiscountEndTime, animation: .default) }
                                )
                            }
                            .frame(width: Device.WidthWithPadding)
                            
                            VStack(spacing: 8) {
                                HStack(spacing: 0) {
                                    SuitLabel(text: "휴무일", typo: .h3)
                                    InfiniteSpacer()
                                }
                                SelectDaysView(
                                    // MARK: State - 휴무일 바인딩
                                    days: viewStore.binding(get: \.daysOfWeek, send: .daysOfWeekBinding)
                                ) { idx in
                                    viewStore.send(.tapDaysButton(idx))
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
                        // MARK: Action - '수정완료' 버튼을 누른 경우
                        viewStore.send(.tapBottomButton)
                    }
                }
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden()
            .onChange(of: viewStore.isPop) { isPop in
                if isPop { dismiss() }
            }
            .alert(
                "가게 정보 수정",
                isPresented: viewStore.binding(get: \.isShowingAlert, send: .dismissAlert),
                actions: {
                    Button("취소", role: .destructive) { viewStore.send(.tapAlertCancel) }
                    Button("확인", role: .cancel) { viewStore.send(.tapAlertOK) }
                },
                message: { Text("가게 정보를 수정합니다.") }
            )
            .overlay {
                if viewStore.isLoading {
                    FullScreenProgressView()
                }
            }
        }
    }
}
