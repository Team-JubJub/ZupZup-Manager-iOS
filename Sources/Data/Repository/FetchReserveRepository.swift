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

protocol FetchReserveRepository {
    func fetchReserve(
        storeId: Int,
        completion: @escaping (Result<[ReservationDTO], Error>) -> Void
    )
}

final class FetchReserveRepositoryImpl: FetchReserveRepository {
    
    init() {}
    
    let database = Firestore.firestore()
    
    func fetchReserve(
        storeId: Int,
        completion: @escaping (Result<[ReservationDTO], Error>) -> Void
    ) {
        
        let reservationRef = database.collection("Reservation")
        
        reservationRef.whereField("storeId", isEqualTo: storeId)
            .addSnapshotListener { querySnapshot, err in
                
                var reservationArray = [ReservationDTO]()
                
                if let err = err {
                    print(err.localizedDescription)
                    completion(.failure(err))
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            let reservation = try document.data(as: ReservationDTO.self)
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
