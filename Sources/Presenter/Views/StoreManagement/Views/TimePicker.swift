//
//  TimePicker.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/13.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct TimePicker: View {
    
    let times = [ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23" ]

    let minutes = [ "00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55" ]
    
    @Binding var selectedTime: String
    
    enum Mode {
        case time
        case minute
    }
    
    var mode: Mode
    
    var body: some View {
        VStack {
            Picker("Time", selection: $selectedTime) {
                ForEach(mode == .time ? times : minutes) { time in
                    HStack(spacing: 0) {
                        if mode == .time { Spacer() }
                        SuiteLabel(text: time, typo: .h2)
                            .tag(time)
                        if mode == .minute { Spacer() }
                    }
                }
            }
            .pickerStyle(.wheel)
        }
    }
}
