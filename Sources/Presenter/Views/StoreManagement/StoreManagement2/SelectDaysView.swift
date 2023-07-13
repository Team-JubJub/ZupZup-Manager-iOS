//
//  SelectDaysView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/13.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct SelectDaysView: View {
    
    @Binding var days: [Bool]
    
    let action: (Int) -> Void
    
    var body: some View {
        IvoryRoundedRectangle(width: Device.WidthWithPadding, height: 113)
            .overlay {
                VStack(spacing: 0) {
                    InfiniteSpacer()
                    
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            SuitLabel(text: "매주", typo: .captionSmall, color: .designSystem(.orange400))
                            SuiteLabel(text: makeDaysString(), typo: .headline)
                                .frame(height: 18)
                        }
                        InfiniteSpacer()
                    }
                    .frame(width: Device.WidthWithPadding - Device.HPadding * 2)
                    
                    InfiniteSpacer()
                    
                    Rectangle()
                        .foregroundColor(.designSystem(.ivoryGray200))
                        .frame(height: 1)
                    
                    HStack(spacing: 4) {
                        ForEach(days.indices, id: \.self) { idx in
                            Button {
                                action(idx)
                            } label: {
                                ZStack {
                                    if days[idx] {
                                        Circle()
                                            .stroke(Color.designSystem(.Tangerine300)!, lineWidth: 2)
                                            .foregroundColor(.clear)
                                            .frame(width: Device.Width * 34 / 390, height: Device.Width * 34 / 390)
                                    }
                                    switch idx {
                                    case 0:
                                        SuitLabel(text: makeDaysOfWeek(idx: idx), typo: .subhead, color: .designSystem(.red500))
                                    case 6:
                                        SuitLabel(text: makeDaysOfWeek(idx: idx), typo: .subhead, color: .designSystem(.cyan400))
                                    default:
                                        SuitLabel(text: makeDaysOfWeek(idx: idx), typo: .subhead)
                                    }
                                }
                                .frame(width: Device.Width * 44 / 390, height: Device.Width * 44 / 390)
                            }
                        }
                    }
                    VSpacer(height: 4)
                }
                .frame(height: 113)
            }
    }
}

extension SelectDaysView {
    private func makeDaysOfWeek(idx: Int) -> String {
        switch idx {
        case 0: return "일"
        case 1: return "월"
        case 2: return "화"
        case 3: return "수"
        case 4: return "목"
        case 5: return "금"
        case 6: return "토"
        default: return "일"
        }
    }
    
    private func makeDaysString() -> String {
        let selectedDays = days.indices.filter { days[$0] }
        let temp = selectedDays.map { makeDaysOfWeek(idx: $0) + "요일" }.joined(separator: ", ")
        return temp
    }
}
