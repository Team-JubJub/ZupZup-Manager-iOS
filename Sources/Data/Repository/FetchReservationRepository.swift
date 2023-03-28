//
//  FetchReservation.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/25.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FetchReservationRepository {
    func fetchReservations(
        storeId: Int,
        completion: @escaping (Result<Reservations, Error>) -> Void
    )
}

final class FetchReservationRepositoryImpl: FetchReservationRepository {
    
    init() {}
    
    let database = Firestore.firestore()
    
    func fetchReservations(
        storeId: Int,
        completion: @escaping (Result<Reservations, Error>) -> Void
    ) {
        
        let reservationRef = database.collection("Reservation")
        
        reservationRef.whereField("storeId", isEqualTo: storeId)
            .addSnapshotListener { querySnapshot, err in
                
                var reservationArray = [Reservation]()
                
                if let err = err {
                    print(err.localizedDescription)
                    completion(.failure(err))
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            let reservation = try document.data(as: Reservation.self)
                            reservationArray.append(reservation)
                        } catch {
                            print(error.localizedDescription)
                            completion(.failure(error))
                        }
                    }
                    completion(.success(reservationArray))
                }
            }
    }
}
