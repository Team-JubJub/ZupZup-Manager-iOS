//
//  ToggleStoreStateUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/05/03.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class ToggleStoreStateUseCaseImpl: ToggleStoreStateUseCase {
    
    // TODO: Remove cancellables
    var cancellables = Set<AnyCancellable>()
    
    var service: StoreServiceProtocol
    
    init(service: StoreServiceProtocol = StoreService.shared) {
        self.service = service
    }
    
    func run(at storeId: Int, openState: Bool) async throws {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            self.service.toggleStoreState(at: storeId, openState: openState)
                .sink { completion in
                    // TODO: Error Handling
                    
                } receiveValue: { response in
                    continuation.resume(returning: response)
                }
                .store(in: &cancellables)
        }
    }
}
