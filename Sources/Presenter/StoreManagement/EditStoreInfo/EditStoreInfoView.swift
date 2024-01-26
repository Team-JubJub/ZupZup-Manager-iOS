////
////  EditStoreInfoView.swift
////  ZupZupManager
////
////  Created by YeongJin Jeong on 2023/07/13.
////  Copyright © 2023 ZupZup. All rights reserved.
////
//
//import SwiftUI
//
//import ComposableArchitecture
//
//struct EditStoreInfoView: View {
//    
//    @Environment(\.dismiss) private var dismiss
//    
//    var store: Store<EditStoreInfoState, EditStoreInfoAction>
//    
//    var body: some View {
//        WithViewStore(store) { viewStore in
//            ZStack {
//                VStack(spacing: 0) {
//                    ZStack {
//                        HStack(spacing: 0) {
//                            NavigationBarWithDismiss(label: "설정")
//                            InfiniteSpacer()
//                        }
//                        .frame(height: 42)
//                        
//                        HStack(spacing: 0) {
//                            InfiniteSpacer()
//                            SuiteLabel(text: "가게 정보", typo: .headline)
//                            InfiniteSpacer()
//                        }
//                        .frame(height: 42)
//                    }
//                    
//                    ScrollView {
//                        VStack(spacing: 16) {
//                            VStack(spacing: 0) {
//                                
//                                ImagePickerView(
//                                    // MARK: 이미지 피커 변수 바인딩
//                                    image: viewStore.binding(
//                                        get: { $0.selectedImage },
//                                        send: EditStoreInfoAction.selectedImageChanged
//                                    ),
//                                    imageUrl: viewStore.state.storeImageUrl
//                                ) {
//                                    viewStore.send(.tapImagePicker)  // MARK: Action - 이미지 피커를 누른 경우
//                                }
//                                .frame(height: 250)
//                                .sheet(
//                                    // MARK: 이미지 피커 변수 바인딩
//                                    isPresented: viewStore.binding(
//                                        get: { $0.isShowingImagePicker },
//                                        send: EditStoreInfoAction.dismissImagePicker
//                                    )
//                                ) {
//                                    // MARK: 이미지 피커 호출
//                                    ImagePicker(
//                                        selectedImage: viewStore.binding(
//                                            get: { $0.selectedImage },
//                                            send: EditStoreInfoAction.selectedImageChanged
//                                        )
//                                    )
//                                }
//                                .frame(height: 235)
//                            }
//                            
//                            VStack(spacing: 8) {
//                                HStack(spacing: 0) {
//                                    SuitLabel(text: "영업 시간", typo: .h3)
//                                    InfiniteSpacer()
//                                }
//                                // MARK: 가게 영업 시작 시간, 종료 시간 Time-Picker
//                                AdjustTimeView(
//                                    isShowingStartPicker: viewStore.binding(
//                                        get: { $0.isShowingOpenTimePicker },
//                                        send: EditStoreInfoAction.dismissOpenTimePicker
//                                    ),
//                                    isShowingEndPicker: viewStore.binding(
//                                        get: { $0.isShowingCloseTimePicker },
//                                        send: EditStoreInfoAction.dismissCloseTimePicker
//                                    ),
//                                    // 영업 시작(시간)
//                                    startTime: viewStore.binding(
//                                        get: { $0.openTime },
//                                        send: EditStoreInfoAction.opneTimeChanged
//                                    ),
//                                    // 영업 시작(분)
//                                    startMinute: viewStore.binding(
//                                        get: { $0.openMinute },
//                                        send: EditStoreInfoAction.openMinuteChanged
//                                    ),
//                                    // 영업 종료(시간)
//                                    endTime: viewStore.binding(
//                                        get: { $0.closeTime },
//                                        send: EditStoreInfoAction.closeTimeChanged
//                                    ),
//                                    // 영업 종료(분)
//                                    endMinute: viewStore.binding(
//                                        get: { $0.closeMinute },
//                                        send: EditStoreInfoAction.closeMinuteChanged
//                                    ),
//                                    mode: .open,
//                                    startAction: { viewStore.send(.tapOpenStartTime, animation: .default) },
//                                    endAction: { viewStore.send(.tapOpenEndTime, animation: .default) }
//                                )
//                            }
//                            .frame(width: Device.WidthWithPadding)
//                            
//                            VStack(spacing: 8) {
//                                HStack(spacing: 0) {
//                                    SuitLabel(text: "할인 시간", typo: .h3)
//                                    InfiniteSpacer()
//                                }
//                                // MARK: 마감 할인 시작 시간, 종료 시간 Time-Picker
//                                AdjustTimeView(
//                                    isShowingStartPicker: viewStore.binding(
//                                        get: { $0.isShowingDiscountStartTimePicker },
//                                        send: EditStoreInfoAction.dismissDiscountStartTimePicker
//                                    ),
//                                    isShowingEndPicker: viewStore.binding(
//                                        get: { $0.isShowingDiscountEndTimePicker },
//                                        send: EditStoreInfoAction.dismissDiscountEndTimePicker
//                                    ),
//                                    // 마감 할인 시작(시간)
//                                    startTime: viewStore.binding(
//                                        get: { $0.discountStartTime },
//                                        send: EditStoreInfoAction.discountStartTimeChanged
//                                    ),
//                                    // 마감 할인 시작(분)
//                                    startMinute: viewStore.binding(
//                                        get: { $0.discountStartMinute },
//                                        send: EditStoreInfoAction.discountStartMinuteChanged
//                                    ),
//                                    // 마감 할인 종료 (시간)
//                                    endTime: viewStore.binding(
//                                        get: { $0.discountEndTime },
//                                        send: EditStoreInfoAction.discountEndTimeChanged
//                                    ),
//                                    // 마감 할인 종료(분)
//                                    endMinute: viewStore.binding(
//                                        get: { $0.discountEndMinute },
//                                        send: EditStoreInfoAction.discountEndMinuteChanged
//                                    ),
//                                    mode: .discount,
//                                    startAction: { viewStore.send(.tapDiscountStartTime, animation: .default) },
//                                    endAction: { viewStore.send(.tapDiscountEndTime, animation: .default) }
//                                )
//                            }
//                            .frame(width: Device.WidthWithPadding)
//                            
//                            VStack(spacing: 8) {
//                                HStack(spacing: 0) {
//                                    SuitLabel(text: "휴무일", typo: .h3)
//                                    InfiniteSpacer()
//                                }
//                                SelectDaysView(
//                                    // MARK: State - 휴무일 바인딩
//                                    days: viewStore.binding(
//                                        get: { $0.daysOfWeek },
//                                        send: EditStoreInfoAction.daysOfWeekBinding
//                                    )
//                                ) { idx in
//                                    viewStore.send(.tapDaysButton(idx))
//                                }
//                            }
//                            .frame(width: Device.WidthWithPadding)
//                        }
//                        VSpacer(height: 136)
//                    }
//                }
//                
//                VStack(spacing: 0) {
//                    InfiniteSpacer()
//                    BottomButton(height: 64, text: "수정 완료", textColor: .designSystem(.pureBlack)!) {
//                        // MARK: Action - '수정완료' 버튼을 누른 경우
//                        viewStore.send(.tapBottomButton)
//                    }
//                }
//            }
//            .navigationTitle("")
//            .navigationBarBackButtonHidden()
//            .onChange(of: viewStore.isPop) { isPop in
//                if isPop { dismiss() }
//            }
//            .alert(
//                "가게 정보 수정",
//                isPresented: viewStore.binding(
//                    get: { $0.isShowingAlert },
//                    send: EditStoreInfoAction.dismissAlert
//                ),
//                actions: {
//                    Button("취소", role: .destructive) { viewStore.send(.tapAlertCancel) }
//                    Button("확인", role: .cancel) { viewStore.send(.tapAlertOK) }
//                },
//                message: { Text("가게 정보를 수정합니다.") }
//            )
//            .overlay {
//                if viewStore.isLoading {
//                    FullScreenProgressView()
//                }
//            }
//        }
//    }
//}
