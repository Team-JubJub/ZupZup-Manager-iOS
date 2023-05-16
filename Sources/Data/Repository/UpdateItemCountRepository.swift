//
//  UpdateItemCountRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/16.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol UpdateItemCountRepository {
    func updateItemCount(
        id: Int,
        _ to: [StoreDTO.Merchandise],
        completion: @escaping (Result<Void, Error>) -> Void
    )
}

final class UpdateItemCountRepositoryImpl: UpdateItemCountRepository {
    
    let database = Firestore.firestore()
    
    func updateItemCount(
        id: Int,
        _ to: [StoreDTO.Merchandise],
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let storeRef = database.collection("TestStore").document(id.toString())
        
        var merchandiseListData: [[String: Any]] = []
        
        for merchandise in to {
            let merchandiseData: [String: Any] = [
                "discounted": merchandise.discounted,
                "imgUrl": merchandise.imgUrl,
                "itemId": merchandise.itemId,
                "itemName": merchandise.itemName,
                "price": merchandise.price,
                "stock": merchandise.stock,
                "storeId": merchandise.storeId
            ]
            merchandiseListData.append(merchandiseData)
        }
        
        storeRef.updateData(["merchandiseList": merchandiseListData]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
