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
        completion: @escaping (Result<StoreDTO, NetworkError>) -> Void
    )
}

final class FetchStoreRepositoryImpl: FetchStoreRepository {
    
    init() {}
    
    let database = Firestore.firestore()
    
    func fetchStore(
        storeId: Int,
        completion: @escaping (Result<StoreDTO, NetworkError>) -> Void
    ) {
        
        let storeRef = database.collection("TestStore")
        
        storeRef.document(storeId.toString()).getDocument { document, error in
            if error != nil {
                completion(.failure(NetworkError.requestFailed))
            } else {
                if let document = document, document.exists {
                    do {
                        let store = try document.data(as: StoreDTO.self)
                        completion(.success(store))
                    } catch {
                        completion(.failure(NetworkError.invalidResponse))
                    }
                }
            }
        }
    }
}
