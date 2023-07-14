//
//  ChangeReserveStateRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/04/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ChangeStateRepository {
    func changeState(
        documentID: String,
        state: ReservationCondition,
        completion: @escaping (Result<ReservationCondition, NetworkError>) -> Void
    )
}

final class ChangeStateRepositoryImpl: ChangeStateRepository {
    
    let database = Firestore.firestore()
    
    func changeState(
        documentID: String,
        state: ReservationCondition,
        completion: @escaping (Result<ReservationCondition, NetworkError>) -> Void
    ) {
        // TODO: Reservation으로 수정해야함
//        let reservationRef = database.collection("Reservation")
        let reservationRef = database.collection("TestReservation")
        
        reservationRef.document(documentID).updateData(["state": state.rawString]) { err in
            if let err = err {
                print(err.localizedDescription)
                completion(.failure(NetworkError.invalidResponse))
            } else {
                print("Document successfully written!")
                completion(.success(state))
            }
        }
    }
}
