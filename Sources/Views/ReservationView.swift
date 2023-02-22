//
//  ReservationView.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ReservationView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VSpacer(height: Device.VerticalPadding)
            VStack(spacing: 8) {
                ForEach(0..<8) { _ in
                    ReservationItem()
                }
            }
        }
        .navigationTitle("예약 상황")
    }
}
