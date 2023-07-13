//
//  AdjustTimeView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/13.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct AdjustTimeView: View {
    
    enum Mode {
        case open
        case discount
    }
    
    @Binding var isShowingStartPicker: Bool
    @Binding var isShowingEndPicker: Bool
    
    @Binding var startTime: String
    @Binding var startMinute: String
    
    @Binding var endTime: String
    @Binding var endMinute: String
    
    let mode: Mode
    
    let startAction: () -> Void
    let endAction: () -> Void
    
    var body: some View {
        ZStack {
            IvoryRoundedRectangle(width: Device.WidthWithPadding, height: isShowingStartPicker || isShowingEndPicker ? 200 : 65)
            GeometryReader { geometry in
                Button {
                    startAction()
                } label: {
                    VStack(alignment: .leading, spacing: 0) {
                        SuitLabel(text: mode == .open ? "영업 시간" : "시작 시간", typo: .captionSmall, color: .designSystem(.Tangerine300))
                        SuiteLabel(text: startTime + ":" + startMinute, typo: .headline)
                    }
                }
                .offset(x: Device.HPadding, y: 16)
                
                Button {
                    endAction()
                } label: {
                    VStack(alignment: .leading, spacing: 0) {
                        SuitLabel(text: mode == .discount ? "마감 시간" : "종료 시간", typo: .captionSmall, color: .designSystem(.Tangerine300))
                        SuiteLabel(text: endTime + ":" + endMinute, typo: .headline)
                    }
                }
                .offset(x: geometry.size.width / 2, y: 16)
                
                if isShowingStartPicker || isShowingEndPicker {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.designSystem(.ivoryGray200))
                            .frame(width: Device.WidthWithPadding, height: 1)
                        
                        HStack(spacing: 30) {
                            TimePicker(selectedTime: isShowingStartPicker ? $startTime : $endTime, mode: .time)
                            SuiteLabel(text: ":", typo: .h2)
                            TimePicker(selectedTime: isShowingStartPicker ? $startMinute : $endMinute, mode: .minute)
                        }
                        .frame(width: Device.WidthWithPadding - Device.HPadding * 2, height: isShowingStartPicker || isShowingEndPicker ? 135 : 0)
                    }
                    .offset(y: 65)
                }
            }
        }
    }
}
