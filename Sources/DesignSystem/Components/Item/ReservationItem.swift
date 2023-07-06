//
//  ReservationItem.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ReservationItem: View {
    
    @State var date: String
    @State var menu: String
    @State var time: String
    @State var customer: String
    @State var state: ReservationState
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                Rectangle()
                    .foregroundColor(Color.designSystem(.ivoryGray150))
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 4) {
                        SuitLabel(text: date, typo: .subhead, color: state.dateTextColor)
                        SuiteLabel(text: menu, typo: .h2, color: state.itemTextColor)
                            .lineLimit(1)
                    }
                    Spacer()
                }
                .frame(width: Device.Width * 326 / 390)
            }
            .frame(
                width: Device.Width * 358 / 390,
                height: Device.Height * 104 / 844
            )
            ZStack {
                Rectangle()
                    .foregroundColor(state.stateColor)
                HStack(alignment: .center, spacing: 0) {
                    Image(assetName: state == .cancel ? .ic_clock_white : .ic_clock_black)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: Device.HPadding,
                                bottom: 0,
                                trailing: Device.Width * 6.5 / 390
                            )
                        )
                    SuitLabel(text: time, typo: .body, color: state.bottomTextColor)
                    Spacer()
                    
                    SuitLabel(text: customer, typo: .body, color: state.bottomTextColor)
                        .lineLimit(1)
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: Device.Width * 24 / 390
                            )
                        )
                }
            }
            .frame(
                width: Device.Width * 358 / 390,
                height: Device.Height * 45 / 844
            )
        }
        .cornerRadius(Device.cornerRadious)
    }
}
