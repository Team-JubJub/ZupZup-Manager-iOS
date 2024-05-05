//
//  GetAllItemsUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/29.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class GetAllItemsUseCaseImpl: GetAllItemsUseCase {
    // TODO: Remove Cancellables
    var cancellables = Set<AnyCancellable>()

    internal var service: ItemServiceProtocol
    
    init(service: ItemServiceProtocol = ItemService.shared) {
        self.service = service
    }
    
    func run(at storeId: Int) async throws -> [ItemEntity] {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[ItemEntity], Error>) in
            
            self.service.getAllItems(at: storeId)
                .sink { completion in
                    // TODO: Error Handling
                    
                } receiveValue: { response in
                    continuation.resume(returning: response.map { $0.toItem() })
                }
                .store(in: &cancellables)
        }
    }
}
