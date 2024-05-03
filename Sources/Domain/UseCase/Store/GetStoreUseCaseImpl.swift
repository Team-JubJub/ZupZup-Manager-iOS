//
//  GetStoreUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/27.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class GetStoreUseCaseImpl: GetStoreUseCase {
    
    // TODO: Remove cancellables
    var cancellables = Set<AnyCancellable>()
    
    var service: StoreServiceProtocol
    
    init(service: StoreServiceProtocol = StoreService.shared) {
        self.service = service
    }
    
    func run(at storeId: Int) async throws -> StoreEntity {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<StoreEntity, Error>) in
            
            self.service.getStore(at: storeId)
                .sink { completion in
                    // TODO: Error Handling
                    
                } receiveValue: { response in
                    let entity = response.toStoreEntity()
                    continuation.resume(returning: entity)
                }
                .store(in: &cancellables)
        }
    }
}
