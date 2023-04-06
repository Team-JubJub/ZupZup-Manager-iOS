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
        ScrollView(showsIndicators: false) {
            VSpacer(height: Device.VPadding)
            VStack(spacing: 8) {
                ForEach(reservationStore.reservations, id: \.self) { reservation in
                    NavigationLink {
                        let store = ReservationDetailStore(
                            reservation: reservation
                        )
                        ReserveDetailView(
                            store: store
                        )
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
            }
        }
        .navigationTitle("예약 상황")
    }
}
