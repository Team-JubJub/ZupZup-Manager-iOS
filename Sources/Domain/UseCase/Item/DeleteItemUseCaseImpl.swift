//
//  DeleteItemUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/05/05.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import UIKit
import Combine

final class DeleteItemUseCaseImpl: DeleteItemUseCase {
        
    // TODO: Remove Cancellables
    var cancellables = Set<AnyCancellable>()

    internal var service: ItemServiceProtocol
    
    init(service: ItemServiceProtocol = ItemService.shared) {
        self.service = service
    }
    
    func run(for itemId: Int, at storeId: Int) async throws -> Void {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            self.service.deleteItem(for: itemId, at: storeId)
                .sink { completion in
                    // TODO: Error Handling
                    
                } receiveValue: { response in
                    continuation.resume(returning: response)
                }
                .store(in: &cancellables)
        }
    }
}
