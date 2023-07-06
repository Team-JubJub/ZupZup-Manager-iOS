//
//  ReservationView.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct ReservationView: View {
    
    @StateObject var reservationStore: ReservationStore
    
    var body: some View {
        if reservationStore.isLoading {
            ProgressView()
                .progressViewStyle(.circular)
                .padding()
        } else {
            VSpacer(height: Device.VPadding)
            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    SuiteLabel(text: "예약 상황", typo: .hero, color: .designSystem(.Secondary))
                    InfiniteSpacer()
                }
                .padding(EdgeInsets(top: Device.Height * 46 / 844, leading: Device.HPadding, bottom: Device.Height * 20 / 844, trailing: Device.HPadding))
                
                ForEach(reservationStore.reservations, id: \.self) { reservation in
                    NavigationLink {
                        let store = ReservationDetailStore(
                            reservation: reservation,
                            store: reservationStore.store
                        )
                        ReserveDetailView(store: store)
                    } label: {
                        ReservationItem(
                            date: reservation.date,
                            menu: reservation.orderedItemdName,
                            time: reservation.orderedTime,
                            customer: reservation.customerName,
                            state: reservation.state
                        )
                    }
                }
            }.navigationTitle("")
        }
    }
}
