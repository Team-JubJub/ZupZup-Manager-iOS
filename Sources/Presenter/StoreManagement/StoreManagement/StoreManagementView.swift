//
//  StoreManagementView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/06/05.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import Combine

import ComposableArchitecture

struct StoreManagementView: View {
    
    let store: Store<StoreManagementState, StoreManagementAction>
    
    // MARK: 유즈 케이스
    let editStoreInfoUseCase: EditStoreInfoUseCase = EditStoreInfoUseCaseImpl()
    let editStoreIntroduceUseCase: EditStoreIntroduceUseCase = EditStoreIntroduceUseCaseImpl()
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    SuiteLabel(text: "설정", typo: .hero, color: .designSystem(.Secondary))
                    InfiniteSpacer()
                }
                .padding(EdgeInsets(top: 46, leading: Device.HPadding, bottom: Device.Height * 20 / 844, trailing: Device.HPadding))
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            SuiteLabel(text: "가게", typo: .h3, color: .designSystem(.Secondary))
                            InfiniteSpacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: Device.HPadding, bottom: Device.VPadding, trailing: Device.HPadding))
                        
                        ZStack {
                            IvoryRoundedRectangle(width: Device.Width * 358 / 390, height: 76)
                            
                            HStack(spacing: 0) {
                                switch viewStore.storeEntity.isOpen {
                                case true: RectangleWithIcon(assetName: .ic_day, color: .designSystem(.ivoryGray400)!)
                                case false: RectangleWithIcon(assetName: .ic_night, color: .designSystem(.ivoryGray400)!)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    SystemLabel(text: "가게 영업", typo: .captionSmall, color: .designSystem(.orange400))
                                    SystemLabel(text: viewStore.storeEntity.isOpen ? "지금 영업 중이에요!" : "지금은 문을 닫았어요", typo: .subhead)
                                }
                                .padding(8)
                                
                                InfiniteSpacer()
                                
                                Toggle(
                                    "\(viewStore.storeEntity.isOpen.description)",
                                    isOn: viewStore.binding(
                                        get: { $0.storeEntity.isOpen },
                                        send: StoreManagementAction.tapToggle
                                    )
                                )
                                .toggleStyle(StoreStateToggle())
                                .cornerRadius(24)
                                .frame(width: 52, height: 32)
                            }
                            .frame(width: Device.Width * 326 / 390, height: 44)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding, trailing: 0))
                        
                        ZStack {
                            IvoryRoundedRectangle(width: Device.Width * 358 / 390, height: 192)
                            VStack {
                                HStack(spacing: 0) {
                                    RectangleWithIcon(assetName: .ic_store, color: .designSystem(.ivoryGray400)!)
                                    InfiniteSpacer()
                                    RightChevronButton {
                                        viewStore.send(.tapInfoButton)
                                    }
                                    .navigationDestination(
                                        isPresented: viewStore.binding(
                                            get: { $0.isShowingEditStoreInfo },
                                            send: StoreManagementAction.isShowingEditStoreInfoBinding
                                        )
                                    ) {
                                        let store = Store<EditStoreInfoState, EditStoreInfoAction>(
                                            initialState: EditStoreInfoState(
                                                storeEntity: viewStore.storeEntity
                                            ),
                                            reducer: editStoreInfoReducer,
                                            environment: EditStoreInfoEnvironment(
                                                editStoreInfo: { request in
                                                    return Future { promise in
                                                        editStoreInfoUseCase.editStoreInfo(request: request) { result in
                                                            promise(.success(result))
                                                        }
                                                    }
                                                    .eraseToEffect()
                                                }
                                            )
                                        )
                                        EditStoreInfoView(store: store)
                                            .onDisappear {
                                                viewStore.send(.fetchStore)
                                            }
                                    }
                                }
                                
                                InfiniteSpacer()
                                
                                HStack(spacing: 0) {
                                    SuiteLabel(text: viewStore.state.storeEntity.name, typo: .h3)
                                    InfiniteSpacer()
                                }
                                
                                InfiniteSpacer()
                                
                                HStack(spacing: 0) {
                                    VStack(alignment: .leading, spacing: 0) {
                                        SystemLabel(text: "영업 시간", typo: .captionSmall, color: .designSystem(.orange400))
                                        SuiteLabel(text: "\(viewStore.storeEntity.openTime) ~ \(viewStore.storeEntity.closeTime)", typo: .headline)
                                        SystemLabel(text: viewStore.storeEntity.closedDay.isEmpty ? "연중 무휴" : "", typo: .captionSmall, color: .designSystem(.ivoryGray400))
                                        InfiniteSpacer()
                                    }
                                    .frame(width: Device.Width * 159 / 390, height: 55, alignment: .leading)
                                    
                                    HSpacer(width: Device.HPadding / 2)
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        SystemLabel(text: "할인 시간", typo: .captionSmall, color: .designSystem(.orange400))
                                        SuiteLabel(text: "\(viewStore.storeEntity.saleStartTime) ~ \(viewStore.storeEntity.saleEndTime)", typo: .headline)
                                        InfiniteSpacer()
                                    }
                                    .frame(width: Device.Width * 159 / 390, height: 55, alignment: .leading)
                                }
                                .frame(height: 55)
                            }
                            .frame(width: Device.Width * 326 / 390, height: 160)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding, trailing: 0))
                        
                        ZStack {
                            IvoryRoundedRectangle(width: Device.Width * 358 / 390, height: 76)
                            
                            HStack(spacing: 0) {
                                RectangleWithIcon(assetName: .ic_date, color: .designSystem(.ivoryGray400)!)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    SystemLabel(text: "가게 소개", typo: .captionSmall, color: .designSystem(.orange400))
                                    SystemLabel(text: viewStore.storeEntity.announcement, typo: .subhead)
                                }
                                .padding(8)
                                
                                InfiniteSpacer()
                                
                                RightChevronButton { viewStore.send(.tapStoreIntroduceButton) }
                            }
                            .frame(width: Device.Width * 326 / 390, height: 44)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: Device.VPadding * 4 / 3, trailing: 0))
                        
                        HStack(spacing: 0) {
                            SuiteLabel(text: "계정", typo: .h3, color: .designSystem(.Secondary))
                            InfiniteSpacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: Device.HPadding, bottom: Device.VPadding * 4 / 3, trailing: Device.HPadding))
                        
                        VStack(spacing: 0) {
                            StoreManageViewItem(title: "고객 센터") { viewStore.send(.tapCustomerCenterButton) }
                            
                            StoreManageViewItem(title: "가게 위치 이전") {
                                // TODO: 가게 위치 이전 구현
                            }
                            
                            StoreManageViewItem(title: "로그아웃") { viewStore.send(.tapLogoutButton) }
                        }
                    }
                    .navigationTitle("")
                }
            }
            .alert(
                viewStore.storeEntity.isOpen ? "가게 문 닫기" : "가게 문 열기",
                isPresented: viewStore.binding(
                    get: { $0.isShowingStoreOpenAlert },
                    send: StoreManagementAction.dismissStoreOpenAlert
                ),
                actions: {
                    Button("아니오", role: .destructive) { viewStore.send(.tapStoreAlertCancel) }
                    Button("네", role: .cancel) { viewStore.send(.tapStoreAlertOk) }
                },
                message: { Text(viewStore.storeEntity.isOpen ? "가게 문을 닫을까요?." : "가게 문을 열까요?") }
            )
            .alert(
                "로그아웃 할까요?",
                isPresented: viewStore.binding(
                    get: { $0.isShowingLogoutAlert },
                    send: StoreManagementAction.dismissLogoutAlert
                ),
                actions: {
                    Button("아니오", role: .destructive) { viewStore.send(.tapLogoutAlertCancel) }
                    Button("네", role: .cancel) { viewStore.send(.tapLogoutAlertOK) }
                },
                message: { Text("로그아웃 하시겠습니까?") }
            )
            .overlay {
                if viewStore.isLoading {
                    FullScreenProgressView()
                }
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: { $0.isShowingStoreIntroduce },
                    send: StoreManagementAction.isShowingStoreIntroduceBinding
                )
            ) {
                
                let store = Store<StoreIntroduceState, StoreIntroduceAction>(
                    initialState: StoreIntroduceState(viewStore.storeEntity),
                    reducer: storeIntroduceReducer,
                    environment: StoreIntroduceEnvironment(
                        editStoreIntroduce: { request in
                            return Future { promise in
                                editStoreIntroduceUseCase.editStoreIntroduce(request: request) { result in
                                    promise(.success(result))
                                }
                            }
                            .eraseToEffect()
                        }
                    )
                )
                StoreIntroduceView(store: store)
                    .onDisappear {
                        viewStore.send(.fetchStore)
                    }
            }
        }
    }
}
