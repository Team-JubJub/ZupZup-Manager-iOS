//
//  DeleteStoreUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/29.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class DeleteStoreUseCaseImpl: DeleteStoreUseCase {
    // TODO: Remove Cancellables
    var cancellables = Set<AnyCancellable>()

    internal var service: StoreServiceProtocol
    
    init(service: StoreServiceProtocol = StoreService.shared) {
        self.service = service
    }
    
    func run(at storeId: Int) async throws -> Void {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            
            self.service.deleteStore(at: storeId)
                .sink { completion in
                    // TODO: Error Handling
                    
                } receiveValue: { response in
                    continuation.resume(returning: response)
                }
                .store(in: &cancellables)
        }
    }
}
