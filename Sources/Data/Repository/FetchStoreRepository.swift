//
//  FetchStoreRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/05/15.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FetchStoreRepository {
    func fetchStore(
        storeId: Int,
        completion: @escaping (Result<StoreDTO, Error>) -> Void
    )
}

final class FetchStoreRepositoryImpl: FetchStoreRepository {
    
    init() {}
    
    let database = Firestore.firestore()
    
    func fetchStore(
        storeId: Int,
        completion: @escaping (Result<StoreDTO, Error>) -> Void
    ) {
        
        let storeRef = database.collection("TestStore")
        
        storeRef.document(storeId.toString()).getDocument { document, error in
            if let error = error {
                dump(error.localizedDescription)
                completion(.failure(error))
            } else {
                if let document = document, document.exists {
                    do {
                        let store = try document.data(as: StoreDTO.self)
                        completion(.success(store))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
