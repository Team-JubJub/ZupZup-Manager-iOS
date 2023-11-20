//
//  EmptyReservationView.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 11/20/23.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct EmptyReservationView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(assetName: .ic_empty_image)
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
            
            SuiteLabel(
                text: "지금은 신규 주문이 없어요",
                typo: .headline,
                color: .designSystem(.ivoryGray500)
            )
        }
    }
}
