//
//  StoreManagementView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/06/05.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct StoreManagementView: View {
    
    let store: Store<StoreManagementState, StoreManagementAction>
    
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
                                switch viewStore.state.isToggleOn {
                                case true: RectangleWithIcon(assetName: .ic_day, color: .designSystem(.ivoryGray400)!)
                                case false: RectangleWithIcon(assetName: .ic_night, color: .designSystem(.ivoryGray400)!)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    SystemLabel(text: "가게 영업", typo: .captionSmall, color: .designSystem(.orange400))
                                    SystemLabel(text: viewStore.state.isToggleOn ? "지금 영업 중이에요!" : "지금은 문을 닫았어요", typo: .subhead)
                                }
                                .padding(8)
                                
                                InfiniteSpacer()
                                
                                Toggle(
                                    "\(viewStore.isToggleOn.description)",
                                    isOn: viewStore.binding(
                                        get: { $0.isToggleOn },
                                        send: StoreManagementAction.isToggleOnBinding
                                    )
                                )
                                    .toggleStyle(StoreStateToggle(action: { print("스위치 탭") }))
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
                                        EditStoreInfoView(store: EditStoreInfoStore())
                                    }
                                }
                                
                                InfiniteSpacer()
                                
                                HStack(spacing: 0) {
                                    SuiteLabel(text: "갱얼쥐 주인", typo: .h3)
                                    InfiniteSpacer()
                                }
                                
                                InfiniteSpacer()
                                
                                HStack(spacing: 0) {
                                    VStack(alignment: .leading, spacing: 0) {
                                        SystemLabel(text: "영업 시간", typo: .captionSmall, color: .designSystem(.orange400))
                                        SuiteLabel(text: "09:00 ~ 21:00", typo: .headline)
                                        SystemLabel(text: "영업 시간", typo: .captionSmall, color: .designSystem(.ivoryGray400))
                                        InfiniteSpacer()
                                    }
                                    .frame(width: Device.Width * 159 / 390, height: 55, alignment: .leading)
                                    
                                    HSpacer(width: Device.HPadding / 2)
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        SystemLabel(text: "할인 시간", typo: .captionSmall, color: .designSystem(.orange400))
                                        SuiteLabel(text: "09:00 ~ 21:00", typo: .headline)
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
                                    SystemLabel(text: "안녕하세요 저희는 150년간 안녕하세요 저희는 150년간...", typo: .subhead)
                                }
                                .padding(8)
                                
                                InfiniteSpacer()
                                
                                RightChevronButton {
                                    // TODO: 가게 소개 화면으로 전환
                                    print("가게 소개")
                                }
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
                            StoreManageViewItem(title: "고객 센터") {
                                // TODO: 고객센터 화면 전환
                                print("고객센터 화면 전환")
                            }
                            
                            StoreManageViewItem(title: "가게 위치 이전") {
                                // TODO: 가게 위치 이전 화면 전환
                                print("가게 위치 이전 화면 전환")
                            }
                            
                            StoreManageViewItem(title: "로그아웃") {
                                // TODO: 가게 위치 이전 화면 전환
                                print("로그아웃 버튼")
                            }
                        }
                    }
                    .navigationTitle("")
                }
            }
        }
    }
}
